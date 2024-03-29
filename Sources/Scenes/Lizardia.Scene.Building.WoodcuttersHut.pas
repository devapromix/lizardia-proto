﻿unit Lizardia.Scene.Building.WoodcuttersHut;

interface

uses
  Lizardia.Scenes;

type

  { TSceneWoodcuttersHut }

  TSceneWoodcuttersHut = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

{ TSceneWoodcuttersHut }

uses
  SysUtils,
  Lizardia.Game,
  Lizardia.Resources,
  BearLibTerminal,
  Lizardia.Tasks;

procedure TSceneWoodcuttersHut.Render;
var
  LCount: Integer;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(25, 10, 40, 10);
  DrawTitle(12, 'Woodcutter''s Hut');

  LCount := Game.Tasks.GetCount(ttCutTree);
  if (LCount > 0) then
    DrawText(27, 14, Format('%s: %d / +%d', [ResourceBase[rsWood].Name,
      Game.Resource.GetResource(rsWood).Value, LCount]))
  else
    DrawText(27, 14, Format('%s: %d', [ResourceBase[rsWood].Name,
      Game.Resource.GetResource(rsWood).Value]));

  AddButton(17, 'Tab', 'Cut tree');
  AddButton(17, 'Esc', 'Close');

  DrawBar;
end;

procedure TSceneWoodcuttersHut.Update(var AKey: Word);
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
      Game.Tasks.Add(ttCutTree);
    TK_ESCAPE:
      Scenes.SetScene(scWorld);
  end;

end;

end.
