unit Model.SourceUnit;

interface

uses Model.BaseEntity;

type
  TSourceUnit = class(TBaseEntity)
  private
    //уникальный идентификатор записи Источника
    FWho:String;
    //идентификатор сервиса Источника
    FSvcid:String;
    //идентификатор линка Источника
    FLid:String;
    //Unix время даты создания
    FCreated:TDateTime;
    //Unix время даты обновления
    FUpdated:TDateTime;
    procedure SetWho(const Value: String);
    procedure SetSvcid(const Value: String);
    procedure SetLid(const Value: String);
    procedure SetCreated(const Value: TDateTime);
    procedure SetUpdated(const Value: TDateTime);

  public
    property Who:String read FWho write SetWho;
    property Svcid:String  read FSvcid write SetSvcid;
    property Lid:String read FLid write SetLid;
    property Created:TDateTime read FCreated write SetCreated;
    property Updated:TDateTime read FUpdated write SetUpdated;
  end;

implementation

{ TSourceUnit }



procedure TSourceUnit.SetCreated(const Value: TDateTime);
begin
  FCreated := Value;
end;

procedure TSourceUnit.SetLid(const Value: String);
begin
  FLid := Value;
end;

procedure TSourceUnit.SetSvcid(const Value: String);
begin
  FSvcid := Value;
end;

procedure TSourceUnit.SetUpdated(const Value: TDateTime);
begin
  FUpdated := Value;
end;

procedure TSourceUnit.SetWho(const Value: String);
begin
  FWho := Value;
end;

end.
