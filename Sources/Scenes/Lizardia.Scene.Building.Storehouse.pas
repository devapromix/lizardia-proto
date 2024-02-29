unit Lizardia.Scene.Building.Storehouse;

interface

uses
  Lizardia.Scenes;

type

  { TSceneStorehouse }

  TSceneStorehouse = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

uses
  SysUtils,
  BearLibTerminal,
  Lizardia.Game,
  Lizardia.Palette,
  Lizardia.Resources;

{ TSceneResourceList }

procedure TSceneStorehouse.Render;
var
  LResourceEnum: TResourceEnum;
  LLeft, LTop: Integer;
  LNum: Integer;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(10, 1, 70, 29);
  DrawTitle(3, 'STORAGE');

  LTop := 0;
  LLeft := 0;
  for LResourceEnum := Succ(Low(LResourceEnum)) to High(LResourceEnum) do
  begin
    LNum := Game.Resource.GetResource(LResourceEnum).Value;
    DrawText(LLeft * 17 + 12, LTop + 5,
      Game.Resource.GetResource(LResourceEnum).Name);
    DrawText(LLeft * 17 + 12 + (15 - Length(LNum.ToString)), LTop + 5,
      LNum.ToString);
    Inc(LTop);
    if (LTop > 20) then
    begin
      Inc(LLeft);
      LTop := 0;
    end;
  end;

  AddButton(27, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneStorehouse.Update(var AKey: Word);
begin
  if (AKey = TK_MOUSE_LEFT) then
  begin
    if (GetButtonsY = MY) then
      if (MX >= 40) and (MX <= 50) then
        AKey := TK_ESCAPE;
  end;
  case AKey of
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;
end;

end.
