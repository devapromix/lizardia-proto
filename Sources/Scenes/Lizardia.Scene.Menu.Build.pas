unit Lizardia.Scene.Menu.Build;

interface

uses
  Lizardia.Scenes;

type
  TSceneBuild = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

uses
  Math,
  SysUtils,
  Lizardia.Game,
  BearLibTerminal;

{ TSceneBuild }

procedure TSceneBuild.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(20, 10, 50, 10);
  DrawTitle(12, 'BUILD');

  AddButton(17, 'Esc', 'Close');

  DrawBar;

end;

procedure TSceneBuild.Update(var AKey: Word);
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
