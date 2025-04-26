within OpenIPSL.Electrical.GFCs.GFMs.REGFMA1.BasicComponentsAndCntrlSchemes;
model QVdrpCntrlScheme "Q-v droop control scheme without Qmax/Qmin limits"
  extends QVdrpCntrlSchemeBase;
  Modelica.Blocks.Sources.Constant Qlimsig(k=0) "Reactive power limiter signal"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-90})));
equation
  connect(Qlimsig.y, qv_drp1.Qlim)
    annotation (Line(points={{-30,-79},{-30,-48}}, color={0,0,127}));
end QVdrpCntrlScheme;
