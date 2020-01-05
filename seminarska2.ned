//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 
package inet.examples.mrosem2;
import inet.examples.wireless.throughput.WirelessAPWithSink;
import inet.node.ethernet.EtherSwitch;
import inet.networklayer.configurator.ipv6.Ipv6FlatNetworkConfigurator;
import inet.node.ipv6.Router6;
import inet.node.ipv6.StandardHost6;
import inet.node.xmipv6.WirelessHost6;
import ned.DatarateChannel;


network Seminarska1_1
{
    @display("bgb=1107,578");

    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
        }
    submodules:
        client1: StandardHost6 {
            parameters:
                @display("p=250,100;i=device/pc3");
        }
        client2: StandardHost6 {
            parameters:
                @display("p=550,100;i=device/pc3");
        }
        client3: StandardHost6 {
            parameters:
                @display("p=550,300;i=device/pc3");
        }
        client4: StandardHost6 {
            parameters:
                @display("p=673.5437,484.67374;i=device/pc3");
        }
        client5: StandardHost6 {
            parameters:
                @display("p=502.72748,484.67374;i=device/pc3");
        }
        client6: StandardHost6 {
            parameters:
                @display("p=336.07748,484.67374;i=device/pc3");
        }
        server: StandardHost6 {
            parameters:
                @display("p=250,300;i=device/pc2");
        }
        router1: Router6 {
            parameters:
                @display("p=398.57123,202.75749");
        }
        router2: Router6 {
            parameters:
                @display("p=398.57123,338.85498");
        }
        configurator: Ipv6FlatNetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
    connections:
        client1.ethg++ <--> C <--> router1.ethg++;
        client2.ethg++ <--> C <--> router1.ethg++;
        client3.ethg++ <--> C <--> router1.ethg++;
        client1.ethg++ <--> C <--> server.ethg++;
        server.ethg++ <--> C <--> router1.ethg++;
        client6.ethg++ <--> C <--> router2.ethg++;
        client5.ethg++ <--> C <--> router2.ethg++;
        client4.ethg++ <--> C <--> router2.ethg++;
        router2.ethg++ <--> C <--> router1.ethg++;
}

network Seminarska1_2
{
    @display("bgb=1107,578");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
        }
    submodules:
        client1: StandardHost6 {
            @display("p=498.56122,52.7725");
        }
        client2: StandardHost6 {
            @display("p=738.815,404.12625");
        }
        client3: StandardHost6 {
            @display("p=266.63998,404.12625");
        }
        router1: Router6 {
            @display("p=498.56122,158.31749");
        }
        router2: Router6 {
            @display("p=595.77374,287.47125");
        }
        router3: Router6 {
            @display("p=377.74,287.47125");
        }
        configurator: Ipv6FlatNetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
    connections:
        client1.ethg++ <--> C <--> router1.ethg++;
        client2.ethg++ <--> C <--> router2.ethg++;
        client3.ethg++ <--> C <--> router3.ethg++;
        router1.ethg++ <--> C <--> router2.ethg++;
        router2.ethg++ <--> C <--> router3.ethg++;
        router3.ethg++ <--> C <--> router1.ethg++;
}
network Seminarska1_3
{
    parameters:
        int n;
        @display("bgb=1107");
    types:
        channel C extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 10Mbps;
        }
    submodules:
        router: Router6 {
            @display("p=534.66876,272.19498");
        }
        srv: StandardHost6 {
            @display("p=243.03123,270.80624");
        }
        cli[n]: StandardHost6 {
            @display("p=773.53375,143.04124,col,60");
        }
        configurator: Ipv6FlatNetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
    connections:
        srv.ethg++ <--> C <--> router.ethg++;
        for i=0..n-1 {
            cli[i].ethg++ <--> C <--> router.ethg++;
        }
}
