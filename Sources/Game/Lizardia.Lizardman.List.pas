unit Lizardia.Lizardman.List;

interface

uses
  Lizardia.Entity,
  Lizardia.Lizardman,
  Lizardia.Lizardman.Factory;

type
  TLizardmanList = class(TObject)
  private
    FLizardmanFactory: TLizardmanFactory;
    FLizardmanList: TArray<TLizardman>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Draw;
    procedure Add(const AX, AY: Integer);
  end;

implementation

{ TLizardmans }

uses
  Math,
  BearLibTerminal,
  Lizardia.Game;

procedure TLizardmanList.Add(const AX, AY: Integer);
begin
  SetLength(FLizardmanList, Length(FLizardmanList) + 1);
  FLizardmanList[High(FLizardmanList)] := FLizardmanFactory.GenerateRandomLizardman;
  FLizardmanList[High(FLizardmanList)].SetLocation(AX, AY);
end;

procedure TLizardmanList.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(FLizardmanList) - 1 do
    FLizardmanList[I].Free;
  SetLength(FLizardmanList, 0);
end;

constructor TLizardmanList.Create;
begin
  FLizardmanFactory := TLizardmanFactory.Create;
end;

destructor TLizardmanList.Destroy;
begin
  Clear;
  FLizardmanFactory.Free;
  inherited;
end;

procedure TLizardmanList.Draw;
var
  I: Integer;
begin
  terminal_layer(1);
  for I := 0 to Length(FLizardmanList) - 1 do
    with FLizardmanList[I] do
      terminal_print(X - Game.Map.Left, Y - Game.Map.Top, '@');
end;

end.
