unit Model.IEntity;

interface

type
  IEntityInterface = interface
  ['{EE0C48BA-4663-4C9D-847D-80140E7B78B0}']
  procedure SetID(const AID:String);
  procedure SetName(const AName:String);
  procedure SetCaption(const ACaption:String);
  function GetCaption: String;
  function GetID: String;
  function GetName: String;
  property ID:String read GetID write SetID;
  property Name:String read GetName write SetName;
  property Caption:String read GetCaption write SetCaption;
 end;
implementation
end.
