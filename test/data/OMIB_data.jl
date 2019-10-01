############### Data Network ########################

buses = [Bus(1 , #number
                   "Bus 1", #Name
                   "REF" , #BusType (REF, PV, PQ)
                   0, #Angle in radians
                   1.05, #Voltage in pu
                   (min=0.94, max=1.06), #Voltage limits in pu
                   69), #Base voltage in kV
                   Bus(2 , "Bus 2"  , "PV" , 0 , 1.0 , (min=0.94, max=1.06), 69)]

branches = [Line("Line1", #name
                     true, #available
                     0.0, #active power flow initial condition (from-to)
                     0.0, #reactive power flow initial condition (from-to)
                     Arc(from=buses[1], to=buses[2]), #Connection between buses
                     0.01, #resistance in pu
                     0.05, #reactance in pu
                     (from=0.0, to=0.0), #susceptance in pu
                     18.046, #rate in MW
                     1.04)]  #angle limits (-min and max)

#Trip of a single circuit of Line 1 -> Resistance and Reactance doubled.
branch_OMIB_fault = [Line("Line1", #name
                           true, #available
                           0.0, #active power flow initial condition (from-to)
                           0.0, #reactive power flow initial condition (from-to)
                           Arc(from=nodes_OMIB[1], to=nodes_OMIB[2]), #Connection between buses
                           0.02, #resistance in pu
                           0.1, #reactance in pu
                           (from=0.0, to=0.0), #susceptance in pu
                           18.046, #rate in MW
                           1.04)]  #angle limits (-min and max)

loads_case1 = [PowerLoad("Bus1", true, nodes_OMIB[2], PowerSystems.ConstantPower, 0.3, 0.01, 0.3, 0.01)]


############### Data devices ########################

inf_source = StaticSource(1
, #number
                :InfBus, #name
                nodes_OMIB[1], #bus
                1.05, #VR
                0.0, #VI
                0.000001) #Xth

######## Machine Data #########

### Case 1: Classical machine against infinite bus ###
mach = BaseMachine(0.0, #R
                            0.2995, #Xd_p
                            0.7087, #eq_p
                            100.0)  #MVABase

######## Shaft Data #########

### Shaft for Case 1 ###
shaft = SingleMass(3.148, #H
                     2.0) #D



######## PSS Data #########
no_pss = PSSFixed(0.0)


######## TG Data #########

### No TG for Cases 1, 2, 3, 4 ###
no_tg = TGFixed(1.0) #eff

########  AVR Data #########
no_avr = AVRFixed(0.0) #Vf not applicable in Classic Machines
