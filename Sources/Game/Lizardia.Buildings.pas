﻿unit Lizardia.Buildings;

interface

uses
  Lizardia.MapObject;

type
  TBuildingType = (btNone, btTownHall, btStorehouse, btInsulae, btWorkshop,
    btBlacksmiths, btLabrtory, btFarm, btQuarry, btSawmill, btInn, btMill,
    btCoalMine, btSilverMine, btGoldMine, btIronMine, btBarracks);

type

  { TBuilding }

  TBuilding = class(TMapObject)
  private
    FBuildingType: TBuildingType;
    FLevel: Byte;
  public
    constructor Create(const ABuildingType: TBuildingType;
      const AX, AY: Integer);
    destructor Destroy; override;
    property BuildingType: TBuildingType read FBuildingType;
    property Level: Byte read FLevel write FLevel;
  end;

implementation

{ TBuilding }

constructor TBuilding.Create(const ABuildingType: TBuildingType;
  const AX, AY: Integer);
var
  LName: string;
begin
  inherited Create(LName, AX, AY);
  FLevel := 1;
  case ABuildingType of
    btTownHall:
      begin
        LName := 'Town Hall';
        FBuildingType := ABuildingType;
      end;
    btStorehouse:
      begin
        LName := 'Storehouse';
        FBuildingType := ABuildingType;
      end;
    btInsulae:
      begin
        LName := 'Tiny Insulae';
        FBuildingType := ABuildingType;
      end;
  else
    begin
      LName := '';
      FBuildingType := btNone;
    end;
  end;
end;

destructor TBuilding.Destroy;
begin

  inherited;
end;

end.
