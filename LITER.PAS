{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program LITER;

Var
 Value:Real;
 Err:Word;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('LITER : Cette commande permet de convertir une unitÇ de mesure ',
                'de litre en son Çquivalent.');
  WriteLn;
  WriteLn('Syntaxe : LITER valeur');
  WriteLn;
  WriteLn(' valeur  Ce parametre permet d''indiquer la valeur a convertir');
 End
  Else
 Begin
  Val(ParamStr(1),Value,Err);
  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*4:0:0,' tasse');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*4:0:2,' tasse');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*100:0:0,' centilitre (cl)');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*100:0:2,' centilitre (cl)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*1000:0:2,' millilitre (ml)');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*1000:0:2,' millilitre (ml)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*61.023744:0:6,' pouce cube (cu in)');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*61.023744:0:2,' pouce cube (cu in)');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*202.884136:0:6,' cuilläre Ö cafÇ');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*202.884136:0:6,' cuilläre Ö cafÇ');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*4*16.666667:0:3,' cuilläre Ö soupe');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*4*16.666667:0:3,' cuilläre Ö soupe');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*0.219969:0:6,' gallon impÇrial');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*0.219969:0:6,' gallon impÇrial');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*33.814023:0:6,' once liquide');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*33.814023:0:6,' once liquide');

  If Frac(Value)=0.0 Then Begin
   WriteLn(Value:0:0,' litre = ',Value*4*0.000327:0:6,' stäre');
  End
   Else
  WriteLn(Value:0:2,' litre = ',Value*4*0.000327:0:6,' stäre');
 End;
END.

