unit Lizardia.Scene.Building.House;

interface

uses
  Lizardia.Scenes;

type

  { TSceneLizardmanList }

  TSceneLizardmanList = class(TScene)
  private
    FSelectedLizarman: Integer;
    procedure DrawLizardmanInfo();
  public
    constructor Create;
    procedure Render; override;
    procedure Update(var AKey: Word); override;
    property SelectedLizarman: Integer read FSelectedLizarman
      write FSelectedLizarman;
  end;

implementation

uses
  BearLibTerminal,
  SysUtils,
  Lizardia.Game,
  Lizardia.Lizardman.List,
  Lizardia.Palette,
  Lizardia.Resources;

{ TSceneLizardmanList }

constructor TSceneLizardmanList.Create;
begin
  FSelectedLizarman := 0;
end;

procedure TSceneLizardmanList.DrawLizardmanInfo;
begin
  terminal_color(TPalette.Selected);
  terminal_composition(TK_ON);
  DrawText(42, 5, Game.Map.LizardmanList.List[FSelectedLizarman].Name);
  DrawText(42, 5, StringOfChar('_',
    Length(Game.Map.LizardmanList.List[FSelectedLizarman].Name)));
  terminal_composition(TK_OFF);
  terminal_color(TPalette.Default);
end;

procedure TSceneLizardmanList.Render;
var
  LLizardmanIndex: Integer;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(15, 1, 60, 29);
  DrawTitle(3, 'HOUSE');

  for LLizardmanIndex := 0 to Game.Map.LizardmanList.List.Count - 1 do
    if LLizardmanIndex = SelectedLizarman then
      DrawButton(17, LLizardmanIndex + 5, Chr(Ord('A') + LLizardmanIndex),
        Game.Map.LizardmanList.List[LLizardmanIndex].Name, TPalette.Selected)
    else
      DrawButton(17, LLizardmanIndex + 5, Chr(Ord('A') + LLizardmanIndex),
        Game.Map.LizardmanList.List[LLizardmanIndex].Name);

  DrawLizardmanInfo();

  DrawText(42, 19, Format('Food: %d/0',
    [Game.Resource.GetResource(rsFood).Value]));

  AddButton(27, 'U', 'Upgrade house');
  AddButton(27, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneLizardmanList.Update(var AKey: Word);
var
  LLizardmanIndex: Integer;
begin
  if (AKey = TK_MOUSE_LEFT) then
  begin
    if (MX >= 17) and (MX <= 35) then
      case MY of
        5 .. 25:
          AKey := TK_A + (MY - 5);
      end;
    if (GetButtonsY = MY) then
    begin
      if (MX >= 30) and (MX <= 46) then
        AKey := TK_Z;
      if (MX >= 50) and (MX <= 60) then
        AKey := TK_ESCAPE;
    end;
  end;
  case AKey of
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
    TK_Z:
      ;
    TK_A .. TK_U:
      begin
        LLizardmanIndex := AKey - TK_A;
        if LLizardmanIndex > Game.Map.LizardmanList.List.Count - 1 then
          Exit;
        FSelectedLizarman := LLizardmanIndex;
      end;
  end;
end;

end.
