module swaywmipc.core.socket;

static import std.socket;
import swaywmipc.core.protocol : Message;

class Socket : std.socket.Socket {
	private string socketpath;

	this(string socketpath) {
		this.socketpath = socketpath;
		super(std.socket.AddressFamily.UNIX, std.socket.SocketType.STREAM);
		this.connect(new std.socket.UnixAddress(this.socketpath));
	}

	override protected pure nothrow @safe Socket accepting() {
		return this;
	}

	string getPath() {
		return this.socketpath;
	}

	ptrdiff_t send(Message msg) {
		import swaywmipc.core.protocol : serialize;
		return super.send( msg.serialize() );
	}

	//alias receive = std.socket.Socket.receive;
	ptrdiff_t receiveBytes(out ubyte[] buff) {
		import swaywmipc.core.protocol : MAGIC_STRING;

		buff.length = MAGIC_STRING.length + /*payload.length*/uint.sizeof + Message.type.sizeof ;

		ptrdiff_t receivedBytes = super.receive(buff);
		if(receivedBytes <= 0) { return 0; }
		if(receivedBytes != buff.length) {/*hadle error*/}

		buff.length += *cast(uint*)(buff[MAGIC_STRING.length .. MAGIC_STRING.length+uint.sizeof]);
		receivedBytes += super.receive(buff[receivedBytes .. buff.length]);

		if(receivedBytes != buff.length) {/*hadle error*/}

		return receivedBytes;
	}

	ptrdiff_t receive(out Message msg) {
		import swaywmipc.core.protocol : deserialize;

		ubyte[] buff;
		ptrdiff_t receivedBytes = this.receiveBytes(buff);
		if(receivedBytes) {
			msg = buff.deserialize();
		}
		return receivedBytes;
	}
}
