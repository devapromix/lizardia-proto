unit Lizardia.Scene.Building.Well;

interface

uses
  Lizardia.Scenes;

type

  { TSceneWell }

  TSceneWell = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

{ TSceneWell }

uses
  SysUtils,
  Lizardia.Game,
  Lizardia.Resources,
  BearLibTerminal;

procedure TSceneWell.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(25, 10, 40, 10);
  DrawTitle(12, 'WELL');

  DrawText(27, 14, Format('Water: %d/0',
    [Game.Resource.GetResource(rsWater).Value]));

  AddButton(17, 'Tab', 'Draw water');
  AddButton(17, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneWell.Update(var AKey: Word);
begin
  if (AKey = TK_MOUSE_LEFT) then
  begin
    if (GetButtonsY = MY) then
    begin
      if (MX >= 30) and (MX <= 45) then
        AKey := TK_TAB;
      if (MX >= 49) and (MX <= 59) then
        AKey := TK_ESCAPE;
    end;
  end;
  case AKey of
    TK_TAB:
      Game.Resource.ModifyResource(rsWater);
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;

end;

end.
