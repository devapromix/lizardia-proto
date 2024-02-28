unit Lizardia.Scene.Building.Quarry;

interface

uses
  Lizardia.Scenes;

type

  { TSceneQuarry }

  TSceneQuarry = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

{ TSceneQuarry }

uses
  SysUtils,
  Lizardia.Game,
  Lizardia.Resources,
  BearLibTerminal,
  Lizardia.Tasks;

procedure TSceneQuarry.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(25, 10, 40, 10);
  DrawTitle(12, 'STONE QUARRY');

  DrawText(27, 14, Format('Stones: %d / +%d',
    [Game.Resource.GetResource(rsStones).Value,
    Game.Tasks.GetCount(ttMineStones)]));

  AddButton(17, 'Tab', 'Mine stones');
  AddButton(17, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneQuarry.Update(var AKey: Word);
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
      Game.Tasks.Add(ttMineStones);
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;

end;

end.
