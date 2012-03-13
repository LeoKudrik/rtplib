%%%----------------------------------------------------------------------
%%% Copyright (c) 2008-2012 Peter Lemenkov <lemenkov@gmail.com>
%%%
%%% All rights reserved.
%%%
%%% Redistribution and use in source and binary forms, with or without modification,
%%% are permitted provided that the following conditions are met:
%%%
%%% * Redistributions of source code must retain the above copyright notice, this
%%% list of conditions and the following disclaimer.
%%% * Redistributions in binary form must reproduce the above copyright notice,
%%% this list of conditions and the following disclaimer in the documentation
%%% and/or other materials provided with the distribution.
%%% * Neither the name of the authors nor the names of its contributors
%%% may be used to endorse or promote products derived from this software
%%% without specific prior written permission.
%%%
%%% THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ''AS IS'' AND ANY
%%% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%%% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%%% DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
%%% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%%% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
%%% ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%%% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%%% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%%
%%%----------------------------------------------------------------------

-module(dtmf_test).

-include("rtp.hrl").
-include_lib("eunit/include/eunit.hrl").

dtmf_test_() ->
	% Here is how typical DTMF session looks like (I pressed all the keys
	% from 0 to 9 consequently)
	RtpBins = [
		<<16#80,16#e5,16#d6,16#a8,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#a9,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#aa,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d6,16#ab,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#ac,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#ad,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#ae,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#af,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,16#00,16#80,16#03,16#c0>>,
		<<16#80,16#e5,16#d6,16#b9,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#ba,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#bb,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#bc,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#bd,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#00,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#be,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#80,16#04,16#60>>,
		<<16#80,16#65,16#d6,16#bf,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#80,16#04,16#60>>,
		<<16#80,16#65,16#d6,16#c0,16#00,16#00,16#58,16#c0,16#0b,16#65,16#12,16#fa,16#01,16#80,16#04,16#60>>,
		<<16#80,16#e5,16#d6,16#c6,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#c7,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#c8,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d6,16#c9,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#ca,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#80,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#cb,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#80,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#cc,16#00,16#00,16#60,16#e0,16#0b,16#65,16#12,16#fa,16#02,16#80,16#03,16#20>>,
		<<16#80,16#e5,16#d6,16#d3,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#d4,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#d5,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d6,16#d6,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#d7,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#80,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#d8,16#00,16#00,16#69,16#00,16#0b,16#65,16#12,16#fa,16#03,16#80,16#03,16#20>>,
		<<16#80,16#e5,16#d6,16#df,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#e0,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#e1,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d6,16#e2,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#e3,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#00,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#e4,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#80,16#04,16#60>>,
		<<16#80,16#65,16#d6,16#e5,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#80,16#04,16#60>>,
		<<16#80,16#65,16#d6,16#e6,16#00,16#00,16#70,16#80,16#0b,16#65,16#12,16#fa,16#04,16#80,16#04,16#60>>,
		<<16#80,16#e5,16#d6,16#eb,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#ec,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#ed,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#ee,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#ef,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#f0,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#f1,16#00,16#00,16#78,16#00,16#0b,16#65,16#12,16#fa,16#05,16#80,16#03,16#c0>>,
		<<16#80,16#e5,16#d6,16#f8,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d6,16#f9,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d6,16#fa,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d6,16#fb,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d6,16#fc,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d6,16#fd,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#fe,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d6,16#ff,16#00,16#00,16#80,16#20,16#0b,16#65,16#12,16#fa,16#06,16#80,16#03,16#c0>>,
		<<16#80,16#e5,16#d7,16#06,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d7,16#07,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d7,16#08,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d7,16#09,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d7,16#0a,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#80,16#03,16#20>>,
		<<16#80,16#65,16#d7,16#0b,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#80,16#03,16#20>>,
		<<16#80,16#65,16#d7,16#0c,16#00,16#00,16#88,16#e0,16#0b,16#65,16#12,16#fa,16#07,16#80,16#03,16#20>>,
		<<16#80,16#e5,16#d7,16#13,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d7,16#14,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d7,16#15,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d7,16#16,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d7,16#17,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d7,16#18,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d7,16#19,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d7,16#1a,16#00,16#00,16#91,16#00,16#0b,16#65,16#12,16#fa,16#08,16#80,16#03,16#c0>>,
		<<16#80,16#e5,16#d7,16#1f,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#00,16#00,16#a0>>,
		<<16#80,16#65,16#d7,16#20,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#00,16#01,16#40>>,
		<<16#80,16#65,16#d7,16#21,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#00,16#01,16#e0>>,
		<<16#80,16#65,16#d7,16#22,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#00,16#02,16#80>>,
		<<16#80,16#65,16#d7,16#23,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#00,16#03,16#20>>,
		<<16#80,16#65,16#d7,16#24,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d7,16#25,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#80,16#03,16#c0>>,
		<<16#80,16#65,16#d7,16#26,16#00,16#00,16#98,16#80,16#0b,16#65,16#12,16#fa,16#09,16#80,16#03,16#c0>>
	],

	DtmfZero0Bin = <<0,0,0,16#a0>>,
	RtpDtmfZero0Bin = <<16#80,16#e5,16#d6,16#a8,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa, DtmfZero0Bin/binary>>,
	RtpDtmfZero0 = #rtp{
		padding = 0,
		marker = 1,
		payload_type = 101,
		sequence_number = 54952,
		timestamp = 20000,
		ssrc = 191173370,
		csrcs = [],
		extension = null,
		payload = DtmfZero0Bin
	},
	DtmfZero0 = #dtmf{
		event = 0,
		eof = false,
		volume = 0,
		duration = 160
	},

	DtmfZero1Bin = <<0,128,3,192>>,
	RtpDtmfZero1Bin = <<16#80,16#65,16#d6,16#ad,16#00,16#00,16#4e,16#20,16#0b,16#65,16#12,16#fa,DtmfZero1Bin/binary>>,
	RtpDtmfZero1 = #rtp{
		padding = 0,
		marker = 0,
		payload_type = 101,
		sequence_number = 54957,
		timestamp = 20000,
		ssrc = 191173370,
		csrcs = [],
		extension = null,
		payload = DtmfZero1Bin
	},
	DtmfZero1 = #dtmf{
		event = 0,
		eof = true,
		volume = 0,
		duration = 960
	},
	[
		{"Decoding of RTP with DTMF Event 0 (first packet)",
			fun() -> ?assertMatch({ok, RtpDtmfZero0}, rtp:decode(RtpDtmfZero0Bin)) end
		},
		{"Decoding of DTMF Event 0",
			fun() -> ?assertMatch({ok, DtmfZero0}, rtp:decode_dtmf(DtmfZero0Bin)) end
		},
		{"Encoding of RTP with DTMF Event 0 (first packet)",
			fun() -> ?assertMatch(RtpDtmfZero0Bin, rtp:encode(RtpDtmfZero0)) end
		},
		{"Encoding of DTMF Event 0",
			fun() -> ?assertMatch(DtmfZero0Bin, rtp:encode_dtmf(DtmfZero0)) end
		},
		{"Decoding of RTP with DTMF Event 0 (last packet)",
			fun() -> ?assertMatch({ok, RtpDtmfZero1}, rtp:decode(RtpDtmfZero1Bin)) end
		},
		{"Decoding of DTMF Event 0",
			fun() -> ?assertMatch({ok, DtmfZero1}, rtp:decode_dtmf(DtmfZero1Bin)) end
		},
		{"Encoding of RTP with DTMF Event 0 (last packet)",
			fun() -> ?assertMatch(RtpDtmfZero1Bin, rtp:encode(RtpDtmfZero1)) end
		},
		{"Encoding of DTMF Event 0",
			fun() -> ?assertMatch(DtmfZero1Bin, rtp:encode_dtmf(DtmfZero1)) end
		}
	].
