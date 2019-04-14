within ADMSL.T1.Electrical.Analog.Basic;
model Ground "AD version of Modelica.Electrical.Analog.Basic.Ground"
  extends MSL.Electrical.Analog.Basic.Ground(redeclare Interfaces.Pin p);
  extends Utilities.GradientInfo;

equation

  for ad_i in 1:NG loop
    p.g_v[ad_i] = 0;
  end for;

end Ground;
