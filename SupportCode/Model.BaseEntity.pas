unit Model.BaseEntity;

interface

uses SysUtils, Model.IEntity;

type
  TBaseEntity = class(TInterfacedObject, IEntityInterface)
  private
    FName: String;
    FID: String;
    FCaption: String;

    procedure SetID(const AID:String);
    procedure SetName(const AName:String);
    procedure SetCaption(const ACaption:String);
    function GetCaption: String;
    function GetID: String;
    function GetName: String;
  public
    property ID:String read GetID write SetID;
    property Name:String read GetName write SetName;
    property Caption:String read GetCaption write SetCaption;
  end;
implementation

{ BaseEntity }

function TBaseEntity.GetCaption: String;
begin
  Result:=FCaption;
end;

function TBaseEntity.GetID: String;
begin
  Result:=FID;
end;

function TBaseEntity.GetName: String;
begin
  Result:=FName;
end;

procedure TBaseEntity.SetCaption(const ACaption: String);
begin
  if Trim(ACaption) <> ''  then
    FCaption:=Trim(ACaption);
end;

procedure TBaseEntity.SetID(const AID: String);
begin
  if Trim(AID) <> ''  then
    FID:=Trim(AID);
end;

procedure TBaseEntity.SetName(const AName: String);
begin
  if Trim(AName) <> '' then
    FName:=Trim(AName);
end;

end.
