unit Lizardia.Scene.World;

interface

uses
  Lizardia.Scenes;

type

  { TSceneWorld }

  TSceneWorld = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var Key: Word); override;
    class procedure GlobalKeys(var Key: Word);
  end;

implementation

uses
  Math,
  SysUtils,
  BearLibTerminal,
  Lizardia.Game;

{ TSceneWorld }

class procedure TSceneWorld.GlobalKeys(var Key: Word);
begin
  case Key of
    TK_L:
      Scenes.SetScene(scLizardmanList);
  end;
end;

procedure TSceneWorld.Render;
begin
  DrawMap(ScreenWidth, ScreenHeight);

  // DrawBar;

  if (MY >= ScreenHeight - 1) then
    ScrollDown;
  if (MY <= 0) then
    ScrollUp;
  if (MX >= ScreenWidth - 1) then
    ScrollRight;
  if (MX <= 0) then
    ScrollLeft;
end;

procedure TSceneWorld.Update(var Key: Word);
var
  I: Integer;
begin
  if (Key = TK_MOUSE_LEFT) then
  begin

  end;
  if (Key = TK_MOUSE_RIGHT) then
  begin

  end;
  case Key of
      TK_ESCAPE:
        begin
          {if Game.Construct.IsConstruct then
          begin
            Game.Construct.Clear;
            Scenes.Render;
            Exit;
          end
          else if Game.IsOrder then
          begin
            Game.IsOrder := False;
            Exit;
          end; }
          Scenes.SetScene(scGameMenu);
        end;
    TK_LEFT:
      ScrollLeft;
    TK_RIGHT:
      ScrollRight;
    TK_UP:
      ScrollUp;
    TK_DOWN:
      ScrollDown;
    TK_R:
      begin
        Game.Map.Gen;
        ScrollTo(Game.Map.Spawn.X, Game.Map.Spawn.Y);
      end;
    TK_F:begin
        Game.Fullscreen := not Game.Fullscreen;
        Game.Refresh;
end;
  end;
  GlobalKeys(Key);
end;

end.
