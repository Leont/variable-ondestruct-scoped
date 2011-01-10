#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

static const U16 magic_number = 0x5653;

int weak_set(pTHX_ SV* sv, MAGIC* magic) {
    dSP;
    PUSHMARK(SP);
    call_sv(magic->mg_obj, G_VOID | G_DISCARD | G_EVAL | G_KEEPERR);
	return 0;
}

MGVTBL weak_magic = { NULL, weak_set, NULL, NULL, NULL };

MODULE = Variable::OnDestruct::Scoped				PACKAGE = Variable::OnDestruct::Scoped

SV*
on_destruct(variable, subref)
	SV* variable;
	CV* subref;
	PROTOTYPE: \[$@%&*]&
	PREINIT:
	SV* canary;
	CODE:
		canary = newRV_inc(variable);
		sv_rvweaken(canary);
		SvREADONLY_on(canary);
		RETVAL = newRV_noinc(canary);
		sv_magicext(canary, (SV*)subref, PERL_MAGIC_ext, &weak_magic, NULL, 0);
	OUTPUT:
		RETVAL
