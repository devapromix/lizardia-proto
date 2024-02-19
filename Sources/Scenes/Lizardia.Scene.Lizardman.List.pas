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
  Lizardia.Game;

{ TSceneLizardmanList }

procedure TSceneLizardmanList.Render;
// var
// LVehicle: Integer;
begin
  Game.Map.Draw(Self.ScreenWidth, Self.ScreenHeight);

  DrawFrame(15, 5, 60, 19);
  DrawTitle(7, 'LIST OF LIZARDMANS');
  { inherited Render;
    DrawTitle(Game.Company.Name + ' AIRCRAFTS');
    for LVehicle := 0 to Game.Vehicles.AircraftCount - 1 do
    DrawButton(12, LVehicle + 11, Chr(Ord('A') + LVehicle),
    Game.Vehicles.Aircraft[LVehicle].Name); }
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
