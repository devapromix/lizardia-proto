﻿unit Lizardia.Scene.Menu.Game;

interface

uses
  Lizardia.Scenes;

type
  TSceneGameMenu = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: word); override;
  end;

implementation

uses
  BearLibTerminal,
  SysUtils,
  Lizardia.Game,
  Lizardia.Scene.World;

{ TSceneGameMenu }

procedure TSceneGameMenu.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(15, 7, 60, 15);
  DrawTitle(9, 'LIZARDIA');

  DrawButton(17, 11, 'L', 'LIST OF LIZARDMANS');

  AddButton(19, 'Q', 'Quit');
  AddButton(19, 'ESC', 'Close');

  //DrawGameBar;
end;

procedure TSceneGameMenu.Update(var AKey: word);
begin
  if (AKey = TK_MOUSE_LEFT) then
  begin
    case MX of
      17 .. 43:
        case MY of
          11:
            AKey := TK_L;
          12:
            AKey := TK_N;
          14:
            AKey := TK_R;
          15:
            AKey := TK_T;
          16:
            AKey := TK_S;
          17:
            AKey := TK_A;
        end;
      47 .. 73:
        case MY of
          11:
            AKey := TK_G;
          12:
            AKey := TK_I;
          13:
            AKey := TK_U;
          14:
            AKey := TK_D;
          15:
            AKey := TK_B;
          16:
            AKey := TK_P;
          17:
            AKey := TK_X;
        end;
    end;    if (GetButtonsY = MY) then
    begin
      case MX of
        34 .. 41:
          AKey := TK_Q;
        45 .. 55:
          AKey := TK_ESCAPE;
      end;
    end;
  end;
  case AKey of
    TK_ESCAPE:
      begin
        Scenes.SetScene(scWorld);
      end;
    TK_Q:
      begin
        Game.IsPause := True;
        Scenes.SetScene(scMainMenu);
      end;
  end;
  TSceneWorld.GlobalKeys(AKey);
end;

end.
