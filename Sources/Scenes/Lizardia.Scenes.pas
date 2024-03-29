﻿unit Lizardia.Scenes;

interface

uses
  BearLibTerminal;

type
  TSceneEnum = (scWorld, scMainMenu, scGameMenu, scBuildMenu, scLizardmanList,
    scStorehouse, scTownHall, scCraft, scWell, scQuarry, scSawmill,
    scWoodcuttersHut);

type
  TButtonRec = record
    ButtonIsActive: Boolean;
    ButtonKey: string;
    ButtonLabel: string;
  end;

type
  TScene = class(TObject)
  private
    FMX: Integer;
    FMY: Integer;
    FButtonsY: Integer;
    FButtons: array [0 .. 4] of TButtonRec;
    FRX: Integer;
    FRY: Integer;
  public
    procedure Render; virtual; abstract;
    procedure Update(var Key: Word); virtual; abstract;
    procedure DrawChar(const AX, AY: Word; AChar: Char);
    procedure DrawText(const X, Y: Integer;
      Text, Color, BkColor: string); overload;
    procedure DrawText(const X, Y: Integer; Text: string;
      const Align: Integer = TK_ALIGN_LEFT); overload;
    procedure DrawText(const Y: Integer; Text: string); overload;
    procedure DrawMoney(const X, Y, Money: Integer;
      const Align: Integer = TK_ALIGN_RIGHT; F: Boolean = False);
    procedure DrawBarButton(const X, Y: Integer; IsActive: Boolean;
      Button, Text: string);
    procedure DrawButton(const X, Y: Integer; IsActive: Boolean;
      Button, Text: string); overload;
    procedure DrawButton(const Y: Integer; IsActive: Boolean;
      Button, Text: string); overload;
    procedure DrawButton(const X, Y: Integer; Button, Text: string); overload;
    procedure DrawButton(const X, Y: Integer;
      Button, Text, Color: string); overload;
    procedure DrawButton(const Y: Integer; Button, Text: string); overload;
    function MakeButton(const IsActive: Boolean;
      const Button, Text: string): string;
    procedure DrawTitle(const Y: Integer; const Title: string); overload;
    procedure DrawTitle(const Title: string); overload;
    procedure DrawFrame(const X, Y, W, H: Integer);
    procedure DrawMap(const AWidth, AHeight: Integer);
    procedure ClearButtons;
    procedure AddButton(const Y: Integer; const Button, Text: string); overload;
    procedure AddButton(const Y: Integer; const IsActive: Boolean;
      const Button, Text: string); overload;
    function GetButton(const N: Integer): TButtonRec;
    function GetButtonsY: Integer;
    procedure RenderButtons;
    procedure DrawBar;
    function ScreenHeight: Integer;
    function ScreenWidth: Integer;
    property MX: Integer read FMX write FMX;
    property MY: Integer read FMY write FMY;
    property RX: Integer read FRX write FRX;
    property RY: Integer read FRY write FRY;
    procedure ScrollTo(const X, Y: Integer);
    procedure ScrollUp;
    procedure ScrollDown;
    procedure ScrollLeft;
    procedure ScrollRight;
  end;

type
  TScenes = class(TScene)
  private
    FScene: array [TSceneEnum] of TScene;
    FSceneEnum: TSceneEnum;
    FBackSceneEnum: array [0 .. 2] of TSceneEnum;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; override;
    procedure Update(var Key: Word); override;
    property Scene: TSceneEnum read FSceneEnum write FSceneEnum;
    function GetScene(I: TSceneEnum): TScene;
    procedure SetScene(SceneEnum: TSceneEnum); overload;
    procedure SetScene(SceneEnum, BackSceneEnum: TSceneEnum); overload;
    procedure Back;
  end;

var
  Scenes: TScenes;

implementation

uses
  Math,
  SysUtils,
  Lizardia.Game,
  Lizardia.Scene.Craft,
  Lizardia.Buildings,
  Lizardia.Scene.Menu.Build,
  Lizardia.Scene.World,
  Lizardia.Scene.Menu.Main,
  Lizardia.Scene.Menu.Game,
  Lizardia.Scene.Building.House,
  Lizardia.Scene.Building.Storehouse,
  Lizardia.Scene.Building.TownHall,
  Lizardia.Scene.Building.Well,
  Lizardia.Scene.Building.Quarry,
  Lizardia.Scene.Building.Sawmill,
  Lizardia.Scene.Building.WoodcuttersHut;

procedure TScene.DrawText(const X, Y: Integer; Text: string;
  const Align: Integer = TK_ALIGN_LEFT);
begin
  terminal_print(X, Y, Align, Text);
end;

procedure TScene.DrawTitle(const Y: Integer; const Title: string);
begin
  terminal_print(ScreenWidth div 2, Y, TK_ALIGN_CENTER,
    '[c=yellow]' + UpperCase(Title) + '[/c]');
end;

procedure TScene.DrawText(const Y: Integer; Text: string);
begin
  terminal_print(ScreenWidth div 2, Y, TK_ALIGN_CENTER, Text);
end;

procedure TScene.DrawText(const X, Y: Integer; Text, Color, BkColor: string);
begin
  terminal_color(Color);
  terminal_bkcolor(BkColor);
  terminal_print(X, Y, Text);
end;

procedure TScene.DrawTitle(const Title: string);
begin
  DrawTitle(9, Title);
end;

function TScene.ScreenWidth: Integer;
begin
  Result := terminal_state(TK_WIDTH);
end;

function TScene.ScreenHeight: Integer;
begin
  Result := terminal_state(TK_HEIGHT);
end;

function TScene.GetButton(const N: Integer): TButtonRec;
begin
  Result := FButtons[N];
end;

function TScene.GetButtonsY: Integer;
begin
  Result := FButtonsY;
end;

procedure TScene.DrawButton(const X, Y: Integer; Button, Text: string);
begin
  terminal_print(X, Y, Format('[c=light yellow][[%s]][/c] [c=white]%s[/c]',
    [UpperCase(Button), UpperCase(Text)]));
end;

procedure TScene.AddButton(const Y: Integer; const Button, Text: string);
begin
  AddButton(Y, True, Button, Text);
end;

procedure TScene.AddButton(const Y: Integer; const IsActive: Boolean;
  const Button, Text: string);
var
  I: Integer;
begin
  FButtonsY := Y;
  for I := Low(FButtons) to High(FButtons) do
    if (FButtons[I].ButtonKey = '') then
    begin
      FButtons[I].ButtonIsActive := IsActive;
      FButtons[I].ButtonKey := Button;
      FButtons[I].ButtonLabel := Text;
      Exit;
    end;
end;

procedure TScene.ClearButtons;
var
  I: Integer;
begin
  for I := Low(FButtons) to High(FButtons) do
  begin
    FButtons[I].ButtonKey := '';
    FButtons[I].ButtonLabel := '';
  end;
end;

procedure TScene.DrawBar;
var
  LEnableButton: Boolean;
  LY: Integer;
begin
  LY := Self.ScreenHeight - 1;
  terminal_color('white');
  terminal_bkcolor('darkest gray');
  terminal_clear_area(0, LY, 90, 1);

  DrawText(56, LY, Format('Turn:%d', [Game.Turn]));
  DrawText(70, LY, Format('Pop:%d/%d', [Game.Map.LizardmanList.List.Count,
    Game.Map.Building[2].Level * 3]));

  LEnableButton := (Scenes.FSceneEnum = scWorld);

  DrawBarButton(0, LY, LEnableButton, 'H', 'OUSE');
  DrawBarButton(8, LY, LEnableButton, 'S', 'TORAGE');
  DrawBarButton(18, LY, LEnableButton, 'B', 'UILD');
  DrawBarButton(26, LY, LEnableButton, 'C', 'RAFT');
  DrawButton(80, LY, LEnableButton, 'ESC', 'MENU');

  if Game.IsPause then
    DrawBarButton(34, LY, LEnableButton, 'P', 'AUSED')
  else
    DrawBarButton(34, LY, LEnableButton, 'P', 'AUSE');
end;

procedure TScene.DrawBarButton(const X, Y: Integer; IsActive: Boolean;
  Button, Text: string);
var
  CB, CT: string;
begin
  if IsActive then
  begin
    CB := 'light yellow';
    CT := 'white';
  end
  else
  begin
    CB := 'gray';
    CT := 'gray';
  end;
  terminal_print(X, Y, Format('[c=' + CB + '][[%s]][/c][c=' + CT + ']%s[/c]',
    [UpperCase(Button), UpperCase(Text)]));
end;

procedure TScene.DrawButton(const Y: Integer; Button, Text: string);
begin
  terminal_print(ScreenWidth div 2, Y, TK_ALIGN_CENTER,
    Format('[c=light yellow][[%s]][/c] [c=white]%s[/c]', [UpperCase(Button),
    UpperCase(Text)]));
end;

procedure TScene.DrawChar(const AX, AY: Word; AChar: Char);
begin
  terminal_put(AX, AY, AChar);
end;

procedure TScene.DrawButton(const X, Y: Integer; Button, Text, Color: string);
begin
  terminal_print(X, Y, Format('[c=light yellow][[%s]][/c] [c=%s]%s[/c]',
    [UpperCase(Button), Color, UpperCase(Text)]));
end;

procedure TScene.DrawButton(const X, Y: Integer; IsActive: Boolean;
  Button, Text: string);
var
  CB, CT: string;
begin
  if IsActive then
  begin
    CB := 'light yellow';
    CT := 'white';
  end
  else
  begin
    CB := 'gray';
    CT := 'gray';
  end;
  terminal_print(X, Y, Format('[c=' + CB + '][[%s]][/c] [c=' + CT + ']%s[/c]',
    [UpperCase(Button), UpperCase(Text)]));
end;

procedure TScene.DrawButton(const Y: Integer; IsActive: Boolean;
  Button, Text: string);
begin
  terminal_print(ScreenWidth div 2, Y, TK_ALIGN_CENTER,
    MakeButton(IsActive, Button, Text));
end;

procedure TScene.DrawFrame(const X, Y, W, H: Integer);
var
  I: Integer;
begin
  terminal_clear_area(X, Y, W, H);
  for I := X + 1 to X + W - 2 do
  begin
    terminal_put(I, Y, $2550);
    terminal_put(I, Y + H - 1, $2550);
  end;
  for I := Y + 1 to Y + H - 2 do
  begin
    terminal_put(X, I, $2551);
    terminal_put(X + W - 1, I, $2551);
  end;
  terminal_put(X, Y, $2554);
  terminal_put(X + W - 1, Y, $2557);
  terminal_put(X, Y + H - 1, $255A);
  terminal_put(X + W - 1, Y + H - 1, $255D);
end;

procedure TScene.DrawMap(const AWidth, AHeight: Integer);
begin
  Game.Map.Draw(AWidth, AHeight);
end;

procedure TScene.DrawMoney(const X, Y, Money: Integer;
  const Align: Integer = TK_ALIGN_RIGHT; F: Boolean = False);
begin
  if Money = 0 then
    terminal_print(X, Y, Align, Format('[c=white]$%d[/c]', [Money]));
  if Money > 0 then
    if F then
      terminal_print(X, Y, Align, Format('[c=green]$%d[/c]', [Money]))
    else
      terminal_print(X, Y, Align, Format('[c=green]+$%d[/c]', [Money]));
  if Money < 0 then
    terminal_print(X, Y, Align, Format('[c=red]-$%d[/c]', [Abs(Money)]));
end;

procedure TScene.ScrollTo(const X, Y: Integer);
begin
  Game.Map.Left := EnsureRange(X - (ScreenWidth div 2), 0,
    Game.Map.Width - ScreenWidth);
  Game.Map.Top := EnsureRange(Y - (ScreenHeight div 2), 0,
    Game.Map.Height - ScreenHeight);
end;

procedure TScene.ScrollUp;
begin
  if (Game.Map.Top > 0) then
    Game.Map.Top := Game.Map.Top - 1;
end;

procedure TScene.ScrollDown;
begin
  if (Game.Map.Top <= Game.Map.Height - ScreenHeight) then
    Game.Map.Top := Game.Map.Top + 1;
end;

procedure TScene.ScrollLeft;
begin
  if (Game.Map.Left > 0) then
    Game.Map.Left := Game.Map.Left - 1;
end;

procedure TScene.ScrollRight;
begin
  if (Game.Map.Left < Game.Map.Width - ScreenWidth) then
    Game.Map.Left := Game.Map.Left + 1;
end;

function TScene.MakeButton(const IsActive: Boolean;
  const Button, Text: string): string;
var
  CB, CT: string;
begin
  if IsActive then
  begin
    CB := 'light yellow';
    CT := 'white';
  end
  else
  begin
    CB := 'gray';
    CT := 'gray';
  end;
  Result := Format('[c=' + CB + '][[%s]][/c] [c=' + CT + ']%s[/c]',
    [UpperCase(Button), UpperCase(Text)]);
end;

procedure TScene.RenderButtons;
var
  I: Integer;
  S: string;
begin
  S := '';
  for I := Low(FButtons) to High(FButtons) do
    if (FButtons[I].ButtonKey <> '') then
    begin
      S := S + MakeButton(FButtons[I].ButtonIsActive, FButtons[I].ButtonKey,
        FButtons[I].ButtonLabel);
      if (I < High(FButtons)) and (FButtons[I + 1].ButtonKey <> '') then
        S := S + ' | ';
    end;
  terminal_bkcolor(0);
  terminal_print(ScreenWidth div 2, FButtonsY, TK_ALIGN_CENTER, S);
end;

constructor TScenes.Create;
var
  I: Integer;
begin
  inherited;
  for I := 0 to High(FBackSceneEnum) do
    FBackSceneEnum[I] := scWorld;
  FScene[scWorld] := TSceneWorld.Create;
  FScene[scMainMenu] := TSceneMainMenu.Create;
  FScene[scGameMenu] := TSceneGameMenu.Create;
  FScene[scStorehouse] := TSceneStorehouse.Create;
  FScene[scLizardmanList] := TSceneLizardmanList.Create;
  FScene[scTownHall] := TSceneTownHall.Create;
  FScene[scCraft] := TSceneCraft.Create;
  FScene[scBuildMenu] := TSceneBuild.Create;
  FScene[scWell] := TSceneWell.Create;
  FScene[scQuarry] := TSceneQuarry.Create;
  FScene[scSawmill] := TSceneSawmill.Create;
  FScene[scWoodcuttersHut] := TSceneWoodcuttersHut.Create;
end;

procedure TScenes.Update(var Key: Word);
begin
  if (FScene[Scene] <> nil) then
    with FScene[Scene] do
    begin
      MX := terminal_state(TK_MOUSE_X);
      MY := terminal_state(TK_MOUSE_Y);
      RX := Game.Map.Left + MX;
      RY := Game.Map.Top + MY;
      Update(Key);
    end;
end;

procedure TScenes.Render;
var
  I: Integer;
begin
  terminal_clear();
  terminal_bkcolor(0);
  if (FScene[Scene] <> nil) then
    with FScene[Scene] do
    begin
      ClearButtons;
      Render;
      RenderButtons;
      terminal_color('white');
      if Game.IsDebug then
      begin
        terminal_print(0, 1, Format('RX:%d, RY:%d', [RX, RY]));
        terminal_print(0, 2, Format('MX:%d, MY:%d', [MX, MY]));
      end;
    end;
  terminal_bkcolor(0);
end;

procedure TScenes.SetScene(SceneEnum, BackSceneEnum: TSceneEnum);
var
  I: Integer;
begin
  for I := 0 to High(FBackSceneEnum) do
    if FBackSceneEnum[I] = scWorld then
    begin
      FBackSceneEnum[I] := BackSceneEnum;
      Break;
    end;
  SetScene(SceneEnum);
end;

destructor TScenes.Destroy;
var
  I: TSceneEnum;
begin
  for I := Low(TSceneEnum) to High(TSceneEnum) do
    FScene[I].Free;
  inherited;
end;

procedure TScenes.SetScene(SceneEnum: TSceneEnum);
begin
  Self.Scene := SceneEnum;
  Self.Render;
end;

function TScenes.GetScene(I: TSceneEnum): TScene;
begin
  Result := FScene[I];
end;

procedure TScenes.Back;
var
  I: Integer;
begin
  for I := High(FBackSceneEnum) downto 0 do
    if FBackSceneEnum[I] <> scWorld then
    begin
      Self.Scene := FBackSceneEnum[I];
      Self.Render;
      FBackSceneEnum[I] := scWorld;
      Exit;
    end;
  if FBackSceneEnum[0] = scWorld then
    SetScene(scWorld);
end;

end.
