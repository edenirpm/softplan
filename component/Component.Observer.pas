unit Component.Observer;

interface
uses
system.Generics.Collections;
Type
 IObserver = interface
   ['{D678D4AE-D7F6-44D8-97FC-E3EC06BB8294}']
   procedure update;
 end;

 IObservable = interface
   ['{7BF85607-EAFC-4B82-9360-D4CA0EA7647A}']
   procedure addObserver(observer:IObserver);
   procedure removeObserver(observer:IObserver);
   procedure notifyObserver;
 end;

 TObservable = class (TInterfacedObject,IObservable)
   private
    FObserverList: TList<IObserver>;
   public
   constructor create;
   Destructor Destroy;Override;
   procedure addObserver(observer:IObserver);
   procedure removeObserver(observer:IObserver);
   procedure notifyObserver;
 end;

implementation

{ TObservable }

procedure TObservable.addObserver(observer: IObserver);
begin
 FObserverList.Add(observer);
end;

constructor TObservable.create;
begin
 FObserverList:=TList<IObserver>.create;
end;

destructor TObservable.Destroy;
begin
  FObserverList.DisposeOf;
  inherited;
end;

procedure TObservable.notifyObserver;
var observer:IObserver;
begin
 for observer in FObserverList do
 begin
    observer.update;
 end;
end;


procedure TObservable.removeObserver(observer: IObserver);
begin
 FObserverList.Remove(observer);
end;

end.
