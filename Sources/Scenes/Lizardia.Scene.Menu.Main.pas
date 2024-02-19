unit Lizardia.Scene.Menu.Main;

interface

uses
  Lizardia.Scenes;

type
  TSceneMainMenu = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

uses
  BearLibTerminal,
  SysUtils,
  Lizardia.Game;

procedure TSceneMainMenu.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(25, 8, 40, 14);
  DrawTitle(10, 'LIZARDIA');

  DrawButton(13, 'ENTER', 'NEW GAME');
  DrawButton(14, Game.IsGame, 'ESC', 'CONTINUE');
  DrawButton(15, False, 'L', 'OPEN GAME');
  DrawButton(16, False, 'D', 'SETTINGS');
  DrawButton(17, 'Q', 'QUIT');

  DrawText(19, 'Apromix (C) 2024');
end;

procedure TSceneMainMenu.Update(var AKey: Word);
begin
  if (AKey = TK_MOUSE_LEFT) then
    case MX of
      37 .. 52:
        case MY of
          13:
            AKey := TK_ENTER;
          14:
            AKey := TK_ESCAPE;
          15:
            AKey := TK_L;
          16:
            AKey := TK_D;
          17:
            AKey := TK_Q;
        end;
    end;
  case AKey of
    TK_ESCAPE:
      if Game.IsGame then
      begin
        Game.IsPause := False;
        Scenes.SetScene(scWorld);
      end;
    TK_ENTER:
      begin
        Game.IsGame := True;
        Game.IsPause := False;
        Game.Map.Gen;
        ScrollTo(Game.Map.Spawn.X, Game.Map.Spawn.Y);
        Scenes.SetScene(scWorld);
      end;
    TK_L:
      begin
        // Game.ScanSaveDir;
        // Scenes.SetScene(scOpenGameMenu);
      end;
    TK_D:
      begin
        // TSceneSettingsMenu(Scenes.GetScene(scSettingsMenu)).IsShowBar := False;
        // Scenes.SetScene(scSettingsMenu, scMainMenu);
      end;
    TK_Q:
      terminal_close();
  end;
end;

end.
