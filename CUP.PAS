{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program CUP;

Var
 Value:Real;
 Err:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('CUP : Cette commande permet de convertir une unit� de mesure ',
                'de tasse en son �quivalent.');
  WriteLn;
  WriteLn('Syntaxe : CUP valeur');
  WriteLn;
  WriteLn(' valeur  Ce parametre permet d''indiquer la valeur a convertir');
 End
  Else
 Begin
  Val(ParamStr(1),Value,Err);
  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*0.25:0:2,' litre');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*0.25:0:2,' litre');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*25:0:2,' centilitre (cl)');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*25:0:2,' centilitre (cl)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*250:0:2,' millilitre (ml)');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*250:0:2,' millilitre (ml)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*61.023744/4:0:6,' pouce cube (cu in)');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*61.023744/4:0:2,' pouce cube (cu in)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*50.0:0:6,' cuill�re � caf�');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*50.0:0:6,' cuill�re � caf�');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*16.666667:0:3,' cuill�re � soupe');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*16.666667:0:3,' cuill�re � soupe');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*0.054992:0:6,' gallon imp�rial');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*0.054992:0:6,' gallon imp�rial');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*8.79877:0:6,' once liquide');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*8.79877:0:6,' once liquide');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' tasse = ',Value*0.000327:0:6,' st�re');
  End
   Else
  WriteLn(Value:0:2,' tasse = ',Value*0.000327:0:6,' st�re');
 End;
END.
