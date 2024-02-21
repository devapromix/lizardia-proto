unit Lizardia.Lizardman.List;

interface

uses
  Lizardia.Entity,
  Lizardia.Lizardman,
  System.Generics.Collections,
  Lizardia.Lizardman.Factory;

type
  TLizardmanList = class(TObject)
  private
    FLizardmanFactory: TLizardmanFactory;
  public
    List: TObjectList<TLizardman>;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AX, AY: Integer);
  end;

implementation

{ TLizardmans }

uses
  Math,
  BearLibTerminal,
  Lizardia.Game,
  Lizardia.Scenes;

procedure TLizardmanList.Add(const AX, AY: Integer);
begin
  { SetLength(FLizardmanList, Length(FLizardmanList) + 1);
    FLizardmanList[High(FLizardmanList)] :=
    FLizardmanFactory.GenerateRandomLizardman;
    FLizardmanList[High(FLizardmanList)].SetLocation(AX, AY); }
  List.Add(FLizardmanFactory.GenerateRandomLizardman);
end;

procedure TLizardmanList.Clear;
// var
// I: Integer;
begin
  { for I := 0 to Length(FLizardmanList) - 1 do
    FLizardmanList[I].Free;
    SetLength(FLizardmanList, 0); }
  List.Clear;
end;

constructor TLizardmanList.Create;
begin
  FLizardmanFactory := TLizardmanFactory.Create;
  List := TObjectList<TLizardman>.Create();
end;

destructor TLizardmanList.Destroy;
begin
  // Clear;
  List.Free;
  FLizardmanFactory.Free;
  inherited;
end;

end.
