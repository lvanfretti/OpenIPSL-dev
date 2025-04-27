within OpenIPSL.Electrical.GFCs.GFMs.REGFMA1.BasicComponentsAndCntrlSchemes;
model QVdrpCntrlScheme "Q-v control scheme without Qlimiters"
  extends QVdrpCntrlSchemeBase;
  Modelica.Blocks.Sources.Constant Qlimsig(k=0) "Reactive power limiter signal"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
equation
  connect(Qlimsig.y, qv_drp1.Qlim)
    annotation (Line(points={{-39,-90},{-30,-90},{-30,-48}}, color={0,0,127}));
end QVdrpCntrlScheme;
