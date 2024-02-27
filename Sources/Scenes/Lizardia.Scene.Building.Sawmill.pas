unit Lizardia.Scene.Building.Sawmill;

interface

uses
  Lizardia.Scenes;

type

  { TSceneSawmill }

  TSceneSawmill = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

{ TSceneSawmill }

uses
  SysUtils,
  Lizardia.Game,
  Lizardia.Resources,
  BearLibTerminal,
  Lizardia.Tasks;

procedure TSceneSawmill.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(25, 10, 40, 10);
  DrawTitle(12, 'SAWMILL');

  DrawText(27, 14, Format('Wood: %d',
    [Game.Resource.GetResource(rsWood).Value]));
  DrawText(27, 15, Format('Planks: %d / +%d',
    [Game.Resource.GetResource(rsPlanks).Value, 999]));

  AddButton(17, 'Tab', 'Make planks');
  AddButton(17, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneSawmill.Update(var AKey: Word);
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
      Game.Resource.AddResource(rsPlanks);
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;

end;

end.
