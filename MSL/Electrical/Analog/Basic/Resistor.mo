within ADMSL.MSL.Electrical.Analog.Basic;
model Resistor "Ideal linear electrical resistor"
  parameter Modelica.SIunits.Resistance R(start=1)
    "Resistance at temperature T_ref";
  parameter Modelica.SIunits.Temperature T_ref=300.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
    "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";

  replaceable partial model Port =
      ADMSL.MSL.Electrical.Analog.Interfaces.OnePort;
  extends Port;
  replaceable partial model CHPort =
        ADMSL.MSL.Electrical.Analog.Interfaces.ConditionalHeatPort1;
  extends CHPort(                    T = T_ref);
  Modelica.SIunits.Resistance R_actual
    "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
  R_actual = R*(1 + alpha*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
<p>The linear resistor connects the branch voltage <i>v</i> with the branch current <i>i</i> by <i>i*R = v</i>. The Resistance <i>R</i> is allowed to be positive, zero, or negative.</p>
</html>",
 revisions="<html>
<ul>
<li><i> August 07, 2009   </i>
       by Anton Haumer<br> temperature dependency of resistance added<br>
       </li>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Rectangle(
            extent={{-70,30},{70,-30}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{90,0}}, color={0,0,255}),
          Text(
            extent={{-144,-40},{142,-72}},
            lineColor={0,0,0},
            textString="R=%R"),
          Line(
            visible=useHeatPort,
            points={{0,-100},{0,-30}},
            color={127,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-152,87},{148,47}},
            textString="%name",
            lineColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
          Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}),
          Line(points={{-96,0},{-70,0}}, color={0,0,255}),
          Line(points={{70,0},{96,0}}, color={0,0,255})}));
end Resistor;
