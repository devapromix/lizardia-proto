unit Lizardia.Scene.Craft;

interface

uses
  Lizardia.Scenes;

type
  TSceneCraft = class(TScene)
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

{ TSceneCraft }

procedure TSceneCraft.Render;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(20, 10, 50, 10);
  DrawTitle(12, 'CRAFT');

  AddButton(17, 'Tab', 'Craft');
  AddButton(17, 'Esc', 'Close');

  DrawBar;

end;

procedure TSceneCraft.Update(var AKey: Word);
begin
  if (AKey = TK_MOUSE_LEFT) then
  begin
    if (GetButtonsY = MY) then
    begin
      if (MX >= 33) and (MX <= 43) then
        AKey := TK_TAB;
      if (MX >= 47) and (MX <= 57) then
        AKey := TK_ESCAPE;
    end;
  end;
  case AKey of
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;

end;

end.
