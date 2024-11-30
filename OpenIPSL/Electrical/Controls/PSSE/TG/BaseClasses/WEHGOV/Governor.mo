within OpenIPSL.Electrical.Controls.PSSE.TG.BaseClasses.WEHGOV;
model Governor "WEHGOV governor and hydraulic actuators"
  parameter Types.ApparentPower S_b=100e6 "System base";
  parameter Types.ApparentPower M_b=100e6 "System base";
  parameter Types.PerUnit R_PERM_PE=1 "Pelec gain";
  parameter Types.PerUnit R_PERM_GATE=1 "Feedback Gate gain";
  parameter Types.Time T_PE=0.5 "Electrical power transducer time constant";
  parameter Integer M=1 "Feedback control switch";
  parameter Types.PerUnit SP_Band=0 "Speed deadband";
  parameter Types.PerUnit KP=3 "Governor proportional gain";
  parameter Types.TimeAging KI=0.36 "Governor integral gain";
  parameter Types.Time KD=1.5 "Governor derivative gain";
  parameter Types.Time TD=0.1 "Governor derivative controller time constant";
  parameter Types.Time TP=0.2 "Pilot valve time constant";
  parameter Types.PerUnit GMAX=1 "Maximum limit for the gate position";
  parameter Types.PerUnit GMIN=0 "Minimum limit for the gate position";
  parameter Types.PerUnit DICN=0.05 "PID integral controller limit from field tuning";
  parameter Types.PerUnit DPV=0 "Change in valve output";
  parameter Types.Time TDV=0.2 "Distribution valve time constant";
  parameter Types.PerUnit GTMXOP=0.1 "Maximum gate opening rate [p.u./s]";
  parameter Types.PerUnit GTMXCL=-0.2 "Maximum gate closing rate [p.u./s]";
  parameter Types.PerUnit Tg=0.2 "Distribution valve limit";
  parameter Types.PerUnit G1=0 "Gate position 1 ";
  parameter Types.PerUnit G2=0.25 "Gate position 2 ";
  parameter Types.PerUnit G3=0.5 "Gate position 3 ";
  parameter Types.PerUnit G4=0.75 "Gate position 4 ";
  parameter Types.PerUnit G5=1 "Gate position 5 ";
  parameter Types.PerUnit FLWG1=0 "Water flow rate 1 ";
  parameter Types.PerUnit FLWG2=0.25 "Water flow rate 2 ";
  parameter Types.PerUnit FLWG3=0.5 "Water flow rate 3 ";
  parameter Types.PerUnit FLWG4=0.75 "Water flow rate 4 ";
  parameter Types.PerUnit FLWG5=1 "Water flow rate 5 ";
  parameter Types.PerUnit FLWP1=0 "Water flow rate 1 ";
  parameter Types.PerUnit FLWP2=0.2 "Water flow rate 2 ";
  parameter Types.PerUnit FLWP3=0.23 "Water flow rate 3 ";
  parameter Types.PerUnit FLWP4=0.4 "Water flow rate 4 ";
  parameter Types.PerUnit FLWP5=0.6 "Water flow rate 5 ";
  parameter Types.PerUnit FLWP6=0.8 "Water flow rate 6 ";
  parameter Types.PerUnit FLWP7=0.87 "Water flow rate 7 ";
  parameter Types.PerUnit FLWP8=0.9 "Water flow rate 8 ";
  parameter Types.PerUnit FLWP9=0.95 "Water flow rate 9 ";
  parameter Types.PerUnit FLWP10=1 "Water flow rate 10 ";
  parameter Types.PerUnit Pmech1=0 "Mechanical power 1 ";
  parameter Types.PerUnit Pmech2=0 "Water flow rate 2 ";
  parameter Types.PerUnit Pmech3=0.05 "Water flow rate 3 ";
  parameter Types.PerUnit Pmech4=0.35 "Water flow rate 4 ";
  parameter Types.PerUnit Pmech5=0.66 "Water flow rate 5 ";
  parameter Types.PerUnit Pmech6=0.82 "Water flow rate 6 ";
  parameter Types.PerUnit Pmech7=0.85 "Water flow rate 7 ";
  parameter Types.PerUnit Pmech8=0.86 "Water flow rate 8 ";
  parameter Types.PerUnit Pmech9=0.88 "Water flow rate 9 ";
  parameter Types.PerUnit Pmech10=0.9 "Water flow rate 10 ";

  Modelica.Blocks.Interfaces.RealInput SPEED
    annotation (Placement(transformation(extent={{-220,-20},{-180,20}}),
        iconTransformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput PELEC
    annotation (Placement(transformation(extent={{-220,-160},{-180,-120}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput PREF
    annotation (Placement(transformation(extent={{-220,120},{-180,160}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  OpenIPSL.NonElectrical.Continuous.SimpleLag PE_Transducer(
    K=R_PERM_PE,
    T=T_PE,
    y_start=s00) annotation (Placement(transformation(extent={{-120,-150},{
            -100,-130}})));
  Modelica.Blocks.Sources.Constant Feedback_Signal_Switch(k=M)
    annotation (Placement(transformation(extent={{-160,-90},{-140,-70}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=1)
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
  Modelica.Blocks.Math.MultiSum multiSum(k={1,-1,-1,-1}, nu=4)
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
  Modelica.Blocks.Nonlinear.DeadZone DeadBand(uMax=SP_Band)
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Continuous.Derivative derivativeLag(
    k=KD,
    T=TD,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Math.Gain gain(k=KP)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator1(
    k=KI,
    outMax=GMAX + DICN,
    outMin=GMIN - DICN,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=sG)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{120,-100},{100,-80}})));
  Modelica.Blocks.Sources.Constant Feedback_Signal_Switch1(k=M)
    annotation (Placement(transformation(extent={{200,-72},{180,-52}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1(threshold=1)
    annotation (Placement(transformation(extent={{160,-72},{140,-52}})));
  Modelica.Blocks.Math.Gain Feedback_Gain(k=R_PERM_GATE)
    annotation (Placement(transformation(extent={{24,-98},{4,-78}})));
  OpenIPSL.NonElectrical.Continuous.SimpleLagLim Pilot_Valve(
    K=1,
    T=TP,
    y_start=sG,
    outMax=GMAX + DPV,
    outMin=GMIN - DPV)
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Modelica.Blocks.Math.Add3 add3_2(k2=-1, k3=-1)
    annotation (Placement(transformation(extent={{182,-10},{202,10}})));
  Modelica.Blocks.Continuous.LimIntegrator Distribution_Valve(
    k=1/TDV,
    outMax=GTMXOP*Tg,
    outMin=GTMXCL*Tg,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{236,-10},{256,10}})));
  Modelica.Blocks.Math.Gain gain1(k=1/Tg)
    annotation (Placement(transformation(extent={{308,-108},{288,-88}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator2(
    outMax=GMAX,
    outMin=GMIN,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=sG)
    annotation (Placement(transformation(extent={{264,-108},{244,-88}})));
  Modelica.Blocks.Interfaces.RealOutput Gate_Position
    annotation (Placement(transformation(extent={{360,-10},{380,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput PMECH0
    annotation (Placement(transformation(extent={{-220,-100},{-180,-60}}),
        iconTransformation(extent={{-140,-50},{-100,-10}})));
protected
  parameter Types.PerUnit Pe0(fixed=false);
  parameter Types.PerUnit Pmech0(fixed=false);
  parameter Types.PerUnit s00(fixed=false);
  parameter Types.PerUnit f0(fixed=false);
  parameter Types.PerUnit p0(fixed=false);
  parameter Types.PerUnit sG(fixed=false);

initial equation
  Pe0 = PELEC;
  Pmech0 = PMECH0;
  s00 = PELEC*R_PERM_PE;
  p0 = Pmech0;

  sG = (if f0 > FLWG4 then ((f0-FLWG4)*(1-G4)/(1-FLWG4) + G4)
 elseif
       f0 <= FLWG4 and f0 > FLWG3 then ((f0-FLWG3)*(G4-G3)/(FLWG4-FLWG3) + G3)
 elseif
       f0 <= FLWG2 then ((f0*G2)/FLWG2)
 else
     (f0-FLWG2)*(G3-G2)/(FLWG3-FLWG2) + G2);

    f0 = (if p0 > Pmech9 then ((p0-Pmech9)*(1-FLWP9)/(Pmech10-Pmech9) + FLWP9)
 elseif
       p0 <= Pmech9 and p0 > Pmech8 then ((p0-Pmech8)*(FLWP9-FLWP8)/(Pmech9-Pmech8) + FLWP8)
 elseif
       p0 <= Pmech8 and p0 > Pmech7 then ((p0-Pmech7)*(FLWP8-FLWP7)/(Pmech8-Pmech7) + FLWP7)
 elseif
       p0 <= Pmech7 and p0 > Pmech6 then ((p0-Pmech6)*(FLWP7-FLWP6)/(Pmech7-Pmech6) + FLWP6)
 elseif
       p0 <= Pmech6 and p0 > Pmech5 then ((p0-Pmech5)*(FLWP6-FLWP5)/(Pmech6-Pmech5) + FLWP5)
 elseif
       p0 <= Pmech5 and p0 > Pmech4 then ((p0-Pmech4)*(FLWP5-FLWP4)/(Pmech5-Pmech4) + FLWP4)
 elseif
       p0 <= Pmech4 and p0 > Pmech3 then ((p0-Pmech3)*(FLWP4-FLWP3)/(Pmech4-Pmech3) + FLWP3)
 elseif
       p0 <= Pmech2 then ((p0*FLWP2)/Pmech2)
 else
     (p0-Pmech2)*(FLWP3-FLWP2)/(Pmech3-Pmech2) + FLWP2);

equation
  connect(PE_Transducer.y, switch1.u3) annotation (Line(points={{-99,-140},
          {-88,-140},{-88,-58},{-82,-58}}, color={0,0,127}));
  connect(Feedback_Signal_Switch.y, realToBoolean.u)
    annotation (Line(points={{-139,-80},{-122,-80}}, color={0,0,127}));
  connect(realToBoolean.y, switch1.u2) annotation (Line(points={{-99,-80},{-94,-80},
          {-94,-50},{-82,-50}}, color={255,0,255}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-119,-40},{-90,-40},{-90,
          -42},{-82,-42}}, color={0,0,127}));
  connect(PREF, multiSum.u[1]) annotation (Line(points={{-200,140},{-84,140},{-84,4},{-46,4},{-46,5.25}},
                             color={0,0,127}));
  connect(SPEED, multiSum.u[2]) annotation (Line(points={{-200,0},{-124,0},{-124,1.75},{-46,1.75}},
                             color={0,0,127}));
  connect(switch1.y, multiSum.u[3]) annotation (Line(points={{-59,-50},{-54,-50},{-54,-2},{-46,-2},{-46,-1.75}},
                                          color={0,0,127}));
  connect(multiSum.y, DeadBand.u)
    annotation (Line(points={{-24.3,0},{-8,0}}, color={0,0,127}));
  connect(DeadBand.y, gain.u)
    annotation (Line(points={{15,0},{38,0}}, color={0,0,127}));
  connect(derivativeLag.u, gain.u)
    annotation (Line(points={{38,50},{26,50},{26,0},{38,0}}, color={0,0,127}));
  connect(limIntegrator1.u, gain.u) annotation (Line(points={{38,-50},{26,-50},{
          26,0},{38,0}}, color={0,0,127}));
  connect(derivativeLag.y, add3_1.u1)
    annotation (Line(points={{61,50},{68,50},{68,8},{78,8}}, color={0,0,127}));
  connect(gain.y, add3_1.u2)
    annotation (Line(points={{61,0},{78,0}}, color={0,0,127}));
  connect(limIntegrator1.y, add3_1.u3) annotation (Line(points={{61,-50},{68,-50},
          {68,-8},{78,-8}}, color={0,0,127}));
  connect(Feedback_Signal_Switch1.y, realToBoolean1.u)
    annotation (Line(points={{179,-62},{162,-62}}, color={0,0,127}));
  connect(realToBoolean1.y, switch2.u2) annotation (Line(points={{139,-62},{132,
          -62},{132,-90},{122,-90}}, color={255,0,255}));
  connect(add3_1.y, switch2.u1) annotation (Line(points={{101,0},{128,0},{128,-82},
          {122,-82}}, color={0,0,127}));
  connect(Feedback_Gain.u, switch2.y)
    annotation (Line(points={{26,-88},{62,-88},{62,-90},{99,-90}},
                                                 color={0,0,127}));
  connect(Feedback_Gain.y, multiSum.u[4]) annotation (Line(points={{3,-88},{-50,-88},{-50,-4},{-46,-4},{-46,-5.25}},
                                               color={0,0,127}));
  connect(Pilot_Valve.u, switch2.u1) annotation (Line(points={{138,0},{128,0},{128,
          -82},{122,-82}}, color={0,0,127}));
  connect(Pilot_Valve.y, add3_2.u1) annotation (Line(points={{161,0},{170,0},{170,
          8},{180,8}}, color={0,0,127}));
  connect(add3_2.u2, switch2.u3) annotation (Line(points={{180,0},{174,0},{174,-40},
          {216,-40},{216,-98},{122,-98}}, color={0,0,127}));
  connect(add3_2.y, Distribution_Valve.u)
    annotation (Line(points={{203,0},{234,0}}, color={0,0,127}));
  connect(Distribution_Valve.y, add3_2.u3) annotation (Line(points={{257,0},{282,
          0},{282,-30},{180,-30},{180,-8}}, color={0,0,127}));
  connect(gain1.u, add3_2.u3) annotation (Line(points={{310,-98},{320,-98},{320,
          0},{282,0},{282,-30},{180,-30},{180,-8}}, color={0,0,127}));
  connect(limIntegrator2.u, gain1.y)
    annotation (Line(points={{266,-98},{287,-98}}, color={0,0,127}));
  connect(limIntegrator2.y, switch2.u3)
    annotation (Line(points={{243,-98},{122,-98}}, color={0,0,127}));
  connect(Gate_Position, switch2.u3) annotation (Line(points={{370,0},{340,
          0},{340,-120},{216,-120},{216,-98},{122,-98}}, color={0,0,127}));
  connect(PELEC, PE_Transducer.u)
    annotation (Line(points={{-200,-140},{-122,-140}}, color={0,0,127}));
  annotation (Icon(graphics={Rectangle(extent={{-100,
              -100},{100,100}},
            lineColor={28,108,200}), Text(
          extent={{-84,60},{88,-56}},
          textColor={28,108,200},
          textString="Governor")}),
                          Diagram(coordinateSystem( extent={{-180,-180},{360,180}})),
                          Documentation(revisions="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td><p>Reference</p></td>
<td><p>WEHGOV governor and hydraulic actuators (PSS/E Manual)</p></td>
</tr>
<tr>
<td><p>Last update</p></td>
<td><p>2024-10-05</p></td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p>Giuseppe Laera, ALSETLab, RPI Rensselaer Polytechnic Institute</p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p>see <a href=\"modelica://OpenIPSL.UsersGuide.Contact\">UsersGuide.Contact</a></p></td>
</tr>
</table>
</html>"));
end Governor;
