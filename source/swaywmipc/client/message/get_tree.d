module swaywmipc.client.message.get_tree;

import swaywmipc.client.common;
import std.json : JSONValue;

unittest {
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `{"id":1,"name":"root","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[3],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"root","nodes":[{"id":2147483647,"name":"__i3","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[2147483646],"border":"none","current_border_width":0,"layout":"output","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"output","nodes":[{"id":2147483646,"name":"__i3_scratch","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"workspace"}]},{"id":3,"name":"eDP-1","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[4],"border":"none","current_border_width":0,"layout":"output","orientation":"none","percent":1.0,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"output","active":true,"primary":false,"make":"Unknown","model":"0x38ED","serial":"0x00000000","scale":1.0,"transform":"normal","current_workspace":"1","modes":[{"width":1920,"height":1080,"refresh":60052}],"current_mode":{"width":1920,"height":1080,"refresh":60052},"nodes":[{"id":4,"name":"1","rect":{"x":0,"y":23,"width":1920,"height":1057},"focused":false,"focus":[6,5],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"num":1,"output":"eDP-1","type":"workspace","representation":"H[URxvt termite]","nodes":[{"id":5,"name":"urxvt","rect":{"x":0,"y":23,"width":960,"height":1057},"focused":false,"focus":[],"border":"normal","current_border_width":2,"layout":"none","orientation":"none","percent":0.5,"window_rect":{"x":2,"y":0,"width":956,"height":1030},"deco_rect":{"x":0,"y":0,"width":960,"height":25},"geometry":{"x":0,"y":0,"width":1124,"height":422},"window":4194313,"urgent":false,"floating_nodes":[],"sticky":false,"type":"con","fullscreen_mode":0,"pid":23959,"app_id":null,"visible":true,"window_properties":{"class":"URxvt","instance":"urxvt","title":"urxvt","transient_for":null},"nodes":[]},{"id":6,"name":"","rect":{"x":960,"y":23,"width":960,"height":1057},"focused":true,"focus":[],"border":"normal","current_border_width":2,"layout":"none","orientation":"none","percent":0.5,"window_rect":{"x":2,"y":0,"width":956,"height":1030},"deco_rect":{"x":0,"y":0,"width":960,"height":25},"geometry":{"x":0,"y":0,"width":817,"height":458},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"con","fullscreen_mode":0,"pid":25370,"app_id":"termite","visible":true,"nodes":[]}]}]}]}`;

	Node root = Node( parseJSON(json) );
	assert( root.id == 1 );
	assert( root.name == "root" );
	assert( root.type == "root" );

	assert( root.floating_nodes.length == 0 );
	assert( root.nodes.length == 2 );

	Node firstChildNode = root.nodes[0];
	assert( firstChildNode.id == 2147483647 );
	assert( firstChildNode.focus.length == 1 && firstChildNode.focus[0] == 2147483646);

	Node secondChildNode = root.nodes[1];
	assert( secondChildNode.id == 3 );
	assert( secondChildNode.name == "eDP-1" );
	assert( secondChildNode.type == "output" );
	assert( secondChildNode.focus.length == 1 && secondChildNode.focus[0] == 4);
	assert( secondChildNode.nodes.length == 1);

}
