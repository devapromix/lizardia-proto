unit Lizardia.Scene.Lizardman.List;

interface

uses
  Lizardia.Scenes;

type

  { TSceneLizardmanList }

  TSceneLizardmanList = class(TScene)
  private

  public
    procedure Render; override;
    procedure Update(var AKey: Word); override;
  end;

implementation

uses
  BearLibTerminal,
  SysUtils,
  Lizardia.Game,
  Lizardia.Lizardman.List;

{ TSceneLizardmanList }

procedure TSceneLizardmanList.Render;
var
  I: Integer;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(15, 5, 60, 19);
  DrawTitle(7, 'LIST OF LIZARDMANS');
  for I := 0 to Game.Map.LizardmanList.List.Count - 1 do
    DrawText(17, I + 9, '++++');
end;

procedure TSceneLizardmanList.Update(var AKey: Word);
// var
// LVehicle: Integer;
begin
  { inherited Update(AKey);
    case AKey of
    TK_A .. TK_G:
    begin
    LVehicle := AKey - TK_A;
    if LVehicle > Game.Vehicles.AircraftCount - 1 then
    Exit;
    Game.Vehicles.CurrentVehicle := LVehicle;
    with Game.Vehicles.Aircraft[LVehicle] do
    ScrollTo(X, Y);
    Scenes.SetScene(scAircraft, scAircrafts);
    end;
    end; }
end;

end.
