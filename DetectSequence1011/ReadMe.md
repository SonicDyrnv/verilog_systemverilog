SystemVerilog Verification Environment: 1011 Sequence Detector
A class-based SystemVerilog testbench environment built to verify a finite state machine (FSM) detecting the non-overlapping binary sequence 1011. The testbench features a layered structure including a generator, driver, monitor, reference model, and scoreboard using mailbox communication and clocking blocks.

🔗 Live Demo & EDA Playground
Run and simulate this project live on EDA Playground:

https://edaplayground.com/x/FLZ_

🏗 System Architecture & Testbench Flow
                     +---------------------------------------+
                     |              Generator                |
                     +-------------------+-------------------+
                                         | (gen2drv)
                                         v
                     +-------------------+-------------------+
                     |                Driver                 |
                     +---------+-----------------+-----------+
                               |                 | (drv2rm)
                               v                 v
                       +---------------+  +--------------+
                       |   DUT Interface  |  | Reference    |
                       +-------+-------+  | Model        |
                               |          +------+-------+
                               v                 | (rm2sb)
                       +---------------+         |
                       |    Monitor    |         |
                       +-------+-------+         |
                               | (mon2sb)        |
                               v                 v
                     +---------+-----------------+-----------+
                     |               Scoreboard              |
                     +---------------------------------------+
📁 Repository Structure
Plaintext
.
├── transactionF.sv       # Transaction class defining input/output packet fields & constraints
├── interfaceF.sv         # Interface with clocking blocks and modports for driver and monitor
├── generatorF.sv         # Generates initial reset and randomized test vectors
├── driverF.sv            # Drives input signals to the DUT via virtual interface
├── monitorF.sv           # Samples DUT output signals synchronized with clocking blocks
├── referencemodelF.sv    # predicting expected DUT outputs
├── scoreboardF.sv       # Compares reference model predictions with actual monitor output
├── environmentF.sv       # Environment wrapper connecting components and mailboxes
└── tb.sv                 # Top-level module connecting DUT, Interface, and Environment
🔑 Key Features
Constrained Random Generation: Biased distribution (rst dist {0:=99, 1:=1}) targeting functional coverage with realistic reset occurrences.

Race-Condition Free Sampling: Uses clocking blocks with input/output skew constraints inside the interface.

Golden Reference Model: Predicts outputs on-the-fly and handles sequence evaluation independently.

Scoreboard Validation: Field-level comparisons between expected and actual response logs with pass/fail metrics.

🛠 How to Run
Just go to the provided link and run it.

Above part of readme file is generated with the help of gemini : https://share.gemini.google/t3HLyk3vfCBs

My experience : 

I have made this one for learning sysverilog verification.
I learnt many things while making this, 
some of those are, 
-> I gave one extra clk delay in monitor class task, since it was sampeling before clk 2ns, which was sampling
    input even before initial and so test cases were getting failed.
-> I learnt about encountering delays in verification, I gave one clk delay(by storing two different times outputs)
    for  comparing in scoreboard, In reference model I did this change, it was something very new which blowed my mind.