within OpenIPSL.Electrical.GFCs.GFMs.REGFMA1.BasicComponentsAndCntrlSchemes;
model QVdrpCntrlScheme "Q-v control scheme with no Q limiters"
  extends QVdrpCntrlSchemeBase;
  Modelica.Blocks.Sources.Constant Qlimsig(k=0) "Active power limiter signal"
    annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));
equation
  connect(Qlimsig.y, qv_drp1.Qlim) annotation (Line(points={{-39,-110},{-30,
          -110},{-30,-48}}, color={0,0,127}));
end QVdrpCntrlScheme;
