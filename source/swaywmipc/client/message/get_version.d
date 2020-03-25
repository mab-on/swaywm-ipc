module swaywmipc.client.message.get_version;

import std.json : JSONValue;

struct Version {
	size_t
		major,
		minor,
		patch;

	string
		human_readable,
		loaded_config_file_name;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "major" in json ) { if(!v.isNull) this.major = v.integer; }
		if( const(JSONValue)* v = "minor" in json ) { if(!v.isNull) this.minor = v.integer; }
		if( const(JSONValue)* v = "patch" in json ) { if(!v.isNull) this.patch = v.integer; }

		if( const(JSONValue)* v = "human_readable" in json ) { if(!v.isNull) this.human_readable = v.str; }
		if( const(JSONValue)* v = "loaded_config_file_name" in json ) { if(!v.isNull) this.loaded_config_file_name = v.str; }
	}
}
