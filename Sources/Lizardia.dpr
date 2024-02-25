program Lizardia;

uses
  System.SysUtils,
  System.Classes,
  Bass in 'Third-Party\Bass\Bass.pas',
  BearLibTerminal in 'Third-Party\BearLibTerminal\BearLibTerminal.pas',
  Lizardia.Entity in 'Game\Lizardia.Entity.pas',
  Lizardia.Palette in 'Game\Lizardia.Palette.pas',
  Lizardia.Lizardman in 'Game\Lizardia.Lizardman.pas',
  Lizardia.Lizardman.Factory in 'Game\Lizardia.Lizardman.Factory.pas',
  Lizardia.Lizardman.List in 'Game\Lizardia.Lizardman.List.pas',
  Lizardia.Map in 'Game\Lizardia.Map.pas',
  Lizardia.Game in 'Game\Lizardia.Game.pas',
  Lizardia.Scenes in 'Scenes\Lizardia.Scenes.pas',
  Lizardia.Scene.World in 'Scenes\Lizardia.Scene.World.pas',
  Lizardia.Scene.Menu.Main in 'Scenes\Lizardia.Scene.Menu.Main.pas',
  Lizardia.Scene.Menu.Game in 'Scenes\Lizardia.Scene.Menu.Game.pas',
  Lizardia.Scene.Lizardman.List in 'Scenes\Lizardia.Scene.Lizardman.List.pas',
  Lizardia.Resources in 'Game\Lizardia.Resources.pas',
  Lizardia.Scene.Storehouse in 'Scenes\Lizardia.Scene.Storehouse.pas',
  Lizardia.Buildings in 'Game\Lizardia.Buildings.pas',
  Lizardia.MapObject in 'Game\Lizardia.MapObject.pas',
  Lizardia.Pop in 'Game\Lizardia.Pop.pas';

var
  Key: Word = 0;
  Tmp: Word = 0;

begin
{$IFDEF DEBUG}
{$IF CompilerVersion > 16}
  ReportMemoryLeaksOnShutdown := True;
{$IFEND}
{$ENDIF}
  Randomize();
  terminal_open();
  terminal_set('window: size=90x30, title="Lizardia";');
  terminal_set('input: filter={keyboard, mouse+}');
  Game := TGame.Create;
  Scenes := TScenes.Create;
  Scenes.SetScene(scMainMenu);
  try
    Scenes.Render;
    terminal_refresh();
    repeat
      Scenes.Render;
      Key := 0;
      if terminal_has_input() then
      begin
        Key := terminal_read();
        Scenes.Update(Key);
        Continue;
      end;
      terminal_refresh();
      terminal_delay(25);
      Game.Step;
    until (Key = TK_CLOSE);
    terminal_close();
  finally
    Scenes.Free;
    Game.Free;
  end;

end.
