
<!-- saved from url=(0061)https://raw.github.com/StalkR/misc/master/irssi/z-dispatch.pl -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><link type="text/css" rel="stylesheet" href="chrome-extension://cpngackimfmofbokmjmljamhdncknpmg/style.css"><script type="text/javascript" charset="utf-8" src="chrome-extension://cpngackimfmofbokmjmljamhdncknpmg/page_context.js"></script></head><body screen_capture_injected="true"><pre style="word-wrap: break-word; white-space: pre-wrap;">use strict;
use warnings;
use Irssi;
use Irssi::Irc;
use vars qw($VERSION %IRSSI);

# renamed to "z-"dispatch to avoid scriptassist searching for a command:
# &gt;&gt; Please wait...
# &lt;&lt; No script provides '/1'

$VERSION = "0.0.3";
%IRSSI = (
        authors     =&gt; "Sebastian 'yath' Schmidt, Tom Wesley",
        contact     =&gt; "yathen\@web.de, tom\@tomaw.net",
        name        =&gt; "Command dispatcher",
        description =&gt; "This scripts sends unknown commands to the server",
        license     =&gt; "GNU GPLv2",
        changed     =&gt; "Tue Mar  5 14:55:29 CET 2002",
);

sub event_default_command {
        my ($command, $server) = @_;

        if ($command =~ /^\d+$/) {
                Irssi::command("window $command");
                Irssi::signal_stop();
                return;
        }

        return if (Irssi::settings_get_bool("dispatch_unknown_commands") == 0
                || !$server
                || $command =~ tr/\/// != 0);
        $server-&gt;send_raw($command);
        Irssi::signal_stop();
}

Irssi::settings_add_bool("misc", "dispatch_unknown_commands", 1);
Irssi::signal_add_first("default command", "event_default_command");
</pre></body></html>