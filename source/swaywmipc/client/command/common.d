module swaywmipc.client.command.common;
import swaywmipc.core;

struct Response {
	Message message;

	bool success() {
		return true;
	}
}

Message makeMessage(Command[] cmd) {
	import std.algorithm : map;
	import std.array : join;

	auto msg = Message();
	msg.type = PayloadType.RUN_COMMAND;

	msg.payload = cmd.map!(c => c.toString()).join(",");

	return msg;
}

class Command {
	private
		string cmd;
		string[] args;

	this(string cmd, string[] args) {
		import std.algorithm : map;
		import std.array : array;
		import std.string : strip, toLower;

		this.cmd = cmd.strip().toLower();
		this.args = args.map!( a => a.strip().toLower() ).array;
	};

	override const string toString() {
		import std.algorithm : map;
		import std.array : join;
		import std.format : format;

		return format!("%s %s")(
			this.cmd,
			this.args.map!(a => format!(`"%s"`)(a) ).join(" ")
		);
	}
}
