within OpenIPSL.Electrical.GFCs.GFMs.REGFMA1.BasicComponentsAndCntrlSchemes;
model PFdrpScheme "P-f droop control scheme model without P limiters"
  extends PFdrpCntrlSchemeBase;
  Modelica.Blocks.Sources.Constant Plimsig(k=0) "Active power limiter signal"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(Plimsig.y, pfdroop.Plim_in)
    annotation (Line(points={{-39,-50},{-8,-50},{-8,-24}}, color={0,0,127}));
end PFdrpScheme;
