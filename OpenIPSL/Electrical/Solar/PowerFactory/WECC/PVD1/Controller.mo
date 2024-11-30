within OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1;
model Controller "Plan Control"
  parameter Types.PerUnit Imax=1.1 "Maximum allowable total converter current";
  parameter Boolean PqFlag "Priority on current limit flag: 1=P prio.; 0 = Q prio.";
  parameter Types.Time Tg=0.02 "Inverter current regulator time constat";
  parameter Types.PerUnit Xc=0 "Line drop compensation reactance";
  parameter Types.PerUnit Qmx=0.328 "Maximum reactive power";
  parameter Types.PerUnit Qmn=-0.328 "Minimum reactive power";
  parameter Types.PerUnit v0=0.9 "Low voltage threshold for Volt/Var Control";
  parameter Types.PerUnit v1=1.1 "High voltage threshold for Volt/Var Control";
  parameter Real dqdv=0 "Voltage/Var droop compensation";
  parameter Types.PerUnit fdbd=-99 "Frequency deadband over frequency response";
  parameter Real Ddn=0 "Down regulation droop";
  parameter Real vr_recov=1 "Amount of generation to reconnect after voltage disconnection";
  parameter Real fr_recov=1 "Amount of generation to reconnect after frequency disconnection";
  parameter Types.PerUnit Ft0=0.99 "Frequency tripping repose curve point 0";
  parameter Types.PerUnit Ft1=0.995 "Frequency tripping repose curve point 1";
  parameter Types.PerUnit Ft2=1.005 "Frequency tripping repose curve point 2";
  parameter Types.PerUnit Ft3=1.01 "Frequency tripping repose curve point 2";
  parameter Types.PerUnit Vt0=0.88 "Voltage tripping repose curve point 0";
  parameter Types.PerUnit Vt1=0.9 "Voltage tripping repose curve point 1";
  parameter Types.PerUnit Vt2=1.1 "Voltage tripping repose curve point 2";
  parameter Types.PerUnit Vt3=1.2 "Voltage tripping repose curve point 3";
  Modelica.Blocks.Interfaces.RealInput Vt annotation (Placement(transformation(extent={{-240,-30},{-200,10}}), iconTransformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput It annotation (Placement(transformation(extent={{-240,-90},{-200,-50}}), iconTransformation(origin={-120,0}, extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Math.Gain compensation(k=Xc) annotation (Placement(transformation(origin={-150,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(origin={-110,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Nonlinear.Limiter numerical_limit(uMax=Modelica.Constants.inf, uMin=0.01) annotation (Placement(transformation(origin={-70,-10}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(origin={90,-30}, extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1.PQPriority qppriority(Imax=Imax, PqFlag=PqFlag) annotation (Placement(transformation(origin={130,0}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Division division1 annotation (Placement(transformation(origin={90,30}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.FirstOrder PCurrentController(
    T=Tg,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=1,
    y_start=Pref/u_0) annotation (Placement(transformation(origin={182,90}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.FirstOrder QCurrentController(
    T=Tg,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=-1,
    y_start=-Qref/u_0) annotation (Placement(transformation(origin={182,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput freq annotation (Placement(transformation(extent={{-240,130},{-200,170}}), iconTransformation(origin={-120,-60}, extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Constant freq_ref(k=1) annotation (Placement(transformation(origin={-182,110}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add2(k1=-1) annotation (Placement(transformation(origin={-130,144}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Nonlinear.DeadZone deadZone(uMax=Modelica.Constants.inf, uMin=fdbd) annotation (Placement(transformation(origin={-90,144}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain frequency_droop(k=Ddn) annotation (Placement(transformation(origin={-50,144}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant active_power_reference(k=Pref) annotation (Placement(transformation(origin={-150,30}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Nonlinear.DeadZone deadband_voltage(uMax=v1, uMin=v0) annotation (Placement(transformation(origin={-70,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain voltage_droop(k=dqdv) annotation (Placement(transformation(origin={-30,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Qmx, uMin=Qmn) annotation (Placement(transformation(origin={50,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(origin={14,-70}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant reactive_power_reference(k=Qref) annotation (Placement(transformation(origin={-70,-110}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput Ip annotation (Placement(transformation(origin={210,90}, extent={{-10,-10},{10,10}}), iconTransformation(origin={110,60}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput Iq annotation (Placement(transformation(origin={210,-70}, extent={{-10,-10},{10,10}}), iconTransformation(origin={110,-60}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add4 annotation (Placement(transformation(origin={-50,50}, extent={{-10,-10},{10,10}})));
  parameter Types.PerUnit Qref "Reactive power refrence";
  parameter Types.PerUnit Pref "Reactive power refrence";
  parameter Types.PerUnit u_0 "Initial voltage";
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(origin={150,90}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(origin={70,150}, extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1.GenerationTripping frequency_tripping(
    Lv0=Ft0,
    Lv1=Ft1,
    Lv2=Ft2,
    Lv3=Ft3,
    recov=fr_recov) annotation (Placement(transformation(origin={30,150}, extent={{-10,-10},{10,10}})));
  OpenIPSL.Electrical.Solar.PowerFactory.WECC.PVD1.GenerationTripping voltage_tripping(
    Lv0=Vt0,
    Lv1=Vt1,
    Lv2=Vt2,
    Lv3=Vt3,
    recov=vr_recov) annotation (Placement(transformation(origin={30,110}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Product product2 annotation (Placement(transformation(origin={70,110}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Product product3 annotation (Placement(transformation(origin={110,130}, extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Product product4 annotation (Placement(transformation(origin={150,-70}, extent={{-10,-10},{10,10}})));
equation
  connect(It, compensation.u) annotation (Line(points={{-220,-70},{-162,-70}}, color={0,0,127}));
  connect(compensation.y, add.u2) annotation (Line(points={{-139,-70},{-130.5,-70},{-130.5,-76},{-122,-76}}, color={0,0,127}));
  connect(Vt, add.u1) annotation (Line(points={{-220,-10},{-128,-10},{-128,-63},{-122,-63},{-122,-64}}, color={0,0,127}));
  connect(numerical_limit.u, Vt) annotation (Line(points={{-82,-10},{-220,-10}}, color={0,0,127}));
  connect(numerical_limit.y, division.u2) annotation (Line(points={{-59,-10},{-8,-10},{-8,-36},{78,-36}}, color={0,0,127}));
  connect(division.y, qppriority.Iq) annotation (Line(points={{101,-30},{106,-30},{106,-5},{118,-5}}, color={0,0,127}));
  connect(division1.u2, numerical_limit.y) annotation (Line(points={{78,24},{-8,24},{-8,-10},{-59,-10}}, color={0,0,127}));
  connect(division1.y, qppriority.Ip) annotation (Line(points={{101,30},{106,30},{106,5},{118,5}}, color={0,0,127}));
  connect(freq, add2.u1) annotation (Line(points={{-220,150},{-142,150}}, color={0,0,127}));
  connect(deadZone.y, frequency_droop.u) annotation (Line(points={{-79,144},{-62,144}}, color={0,0,127}));
  connect(freq_ref.y, add2.u2) annotation (Line(points={{-171,110},{-160,110},{-160,138},{-142,138}}, color={0,0,127}));
  connect(add2.y, deadZone.u) annotation (Line(points={{-119,144},{-102,144}}, color={0,0,127}));
  connect(add.y, deadband_voltage.u) annotation (Line(points={{-99,-70},{-82,-70}}, color={0,0,127}));
  connect(voltage_droop.u, deadband_voltage.y) annotation (Line(points={{-42,-70},{-59,-70}}, color={0,0,127}));
  connect(add1.y, limiter.u) annotation (Line(points={{25,-70},{38,-70}}, color={0,0,127}));
  connect(voltage_droop.y, add1.u1) annotation (Line(points={{-19,-70},{-10,-70},{-10,-69},{2,-69},{2,-64}}, color={0,0,127}));
  connect(reactive_power_reference.y, add1.u2) annotation (Line(points={{-59,-110},{-10,-110},{-10,-95},{2,-95},{2,-76}}, color={0,0,127}));
  connect(limiter.y, division.u1) annotation (Line(points={{61,-70},{62.5,-70},{62.5,-24},{78,-24}}, color={0,0,127}));
  connect(QCurrentController.y, Iq) annotation (Line(points={{193,-70},{210,-70}}, color={0,0,127}));
  connect(PCurrentController.y, Ip) annotation (Line(points={{193,90},{210,90}}, color={0,0,127}));
  connect(active_power_reference.y, add4.u2) annotation (Line(points={{-139,30},{-80,30},{-80,44},{-62,44},{-62,44}}, color={0,0,127}));
  connect(frequency_droop.y, add4.u1) annotation (Line(points={{-39,144},{-34,144},{-34,104},{-80,104},{-80,56},{-62,56}}, color={0,0,127}));
  connect(add4.y, division1.u1) annotation (Line(points={{-39,50},{52,50},{52,36},{78,36},{78,36}}, color={0,0,127}));
  connect(product1.y, PCurrentController.u) annotation (Line(points={{161,90},{170,90},{170,90},{170,90}}, color={0,0,127}));
  connect(product1.u2, qppriority.Ipcmd) annotation (Line(points={{138,84},{126,84},{126,20},{144,20},{144,6},{141,6},{141,5}}, color={0,0,127}));
  connect(frequency_tripping.TrpLow, product.u1) annotation (Line(points={{41,155},{58,155},{58,156},{58,156}}, color={0,0,127}));
  connect(frequency_tripping.TrpHigh, product.u2) annotation (Line(points={{41,145},{58,145},{58,144},{58,144}}, color={0,0,127}));
  connect(frequency_tripping.u, freq) annotation (Line(points={{18,150},{0,150},{0,184},{-188,184},{-188,150},{-220,150}}, color={0,0,127}));
  connect(voltage_tripping.u, Vt) annotation (Line(points={{18,110},{-128,110},{-128,-10},{-220,-10}}, color={0,0,127}));
  connect(voltage_tripping.TrpLow, product2.u1) annotation (Line(points={{41,115},{58,115},{58,116},{58,116}}, color={0,0,127}));
  connect(voltage_tripping.TrpHigh, product2.u2) annotation (Line(points={{41,105},{56,105},{56,104},{58,104}}, color={0,0,127}));
  connect(product.y, product3.u1) annotation (Line(points={{81,150},{90,150},{90,136},{98,136},{98,136}}, color={0,0,127}));
  connect(product2.y, product3.u2) annotation (Line(points={{81,110},{90,110},{90,124},{98,124},{98,124}}, color={0,0,127}));
  connect(product3.y, product1.u1) annotation (Line(points={{121,130},{128,130},{128,96},{138,96},{138,96}}, color={0,0,127}));
  connect(product4.y, QCurrentController.u) annotation (Line(points={{161,-70},{168,-70},{168,-70},{170,-70}}, color={0,0,127}));
  connect(qppriority.Iqcmd, product4.u1) annotation (Line(points={{141,-5},{144,-5},{144,-52},{130,-52},{130,-64},{138,-64},{138,-64}}, color={0,0,127}));
  connect(product4.u2, product3.y) annotation (Line(points={{138,-76},{112,-76},{112,100},{128,100},{128,130},{121,130},{121,130}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}}, initialScale=0.05), graphics={
        Text(
          origin={-186,179},
          lineColor={255,0,0},
          extent={{-8,3},{76,-9}},
          textString="Frequency filtering has to be done outside of this block",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          origin={-67,141},
          lineColor={0,170,0},
          pattern=LinePattern.Dash,
          lineThickness=1,
          extent={{-85,21},{51,-45}}),
        Text(
          origin={-92,171},
          lineColor={0,170,0},
          lineThickness=1,
          extent={{-8,3},{76,-9}},
          textString="Underfrequency Droop Control",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          origin={-67,141},
          lineColor={0,170,0},
          pattern=LinePattern.Dash,
          lineThickness=1,
          extent={{-85,21},{51,-45}}),
        Rectangle(
          origin={-5,-71},
          lineColor={0,170,0},
          pattern=LinePattern.Dash,
          lineThickness=1,
          extent={{-85,21},{79,-57}}),
        Text(
          origin={-120,-41},
          lineColor={0,170,0},
          lineThickness=1,
          extent={{30,-1},{76,-9}},
          textString="Volt/Var Control",
          horizontalAlignment=TextAlignment.Left)}), Icon(graphics={
        Rectangle(
          origin={-24.9099,25},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-74.3452,75},{124.91,-125}}),
        Text(
          extent={{-100,100},{100,70}},
          textString="%name",
          lineColor={0,0,0}),
        Text(
          extent={{-96,66},{-78,48}},
          lineColor={0,0,0},
          textString="Vt"),
        Text(
          extent={{-98,8},{-78,-12}},
          lineColor={0,0,0},
          textString="It"),
        Text(
          extent={{-96,-52},{-76,-72}},
          lineColor={0,0,0},
          textString="freq"),
        Text(
          extent={{70,70},{90,50}},
          lineColor={0,0,0},
          textString="Ip"),
        Text(
          extent={{70,-52},{90,-72}},
          lineColor={0,0,0},
          textString="Iq")}));
end Controller;
