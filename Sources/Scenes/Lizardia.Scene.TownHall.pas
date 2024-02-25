unit Lizardia.Scene.TownHall;

interface

uses
  Lizardia.Scenes;

type

  { TSceneTownHall }

  TSceneTownHall = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

{ TSceneTownHall }

uses
  SysUtils,
  Lizardia.Game,
  BearLibTerminal;

procedure TSceneTownHall.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(20, 10, 50, 10);
  DrawTitle(12, 'TOWN HALL');

  DrawText(22, 14, Format('Population: %d/%d',
    [Game.Map.LizardmanList.List.Count, Game.Map.Building[2].Level * 3]));

  AddButton(17, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneTownHall.Update(var AKey: Word);
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
