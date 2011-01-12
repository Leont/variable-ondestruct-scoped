#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

static const U16 magic_number = 0x5653;

int weak_set(pTHX_ SV* sv, MAGIC* magic) {
    dSP;
    PUSHMARK(SP);
//	Perl_warn(aTHX_ "# Pre: Count = %u, ROK = %d dirty = %d\n", SvREFCNT(sv), SvROK(sv), PL_dirty);
    call_sv(magic->mg_obj, G_VOID | G_DISCARD | G_EVAL | G_KEEPERR);
	if (magic->mg_ptr)
		SvREFCNT_dec((SV*)magic->mg_ptr);
//	Perl_warn(aTHX_ "# Post: Count = %u, ROK = %d dirty = %d\n", SvREFCNT(sv), SvROK(sv), PL_dirty);
	return 0;
}

int weak_destroy(pTHX_ SV* sv, MAGIC* magic) {
//	Perl_warn(aTHX_ "Destroying…\n");
	return 0;
}

MGVTBL weak_magic = { NULL, weak_set, NULL, NULL, weak_destroy };

MODULE = Variable::OnDestruct::Scoped				PACKAGE = Variable::OnDestruct::Scoped

SV*
on_destruct(reference, subref)
	SV* reference;
	CV* subref;
	PROTOTYPE: \[$@%&*]&
	PPCODE:
		SV* canary = newRV_inc(SvRV(reference));
		sv_rvweaken(canary);
		SvREADONLY_on(canary);
		RETVAL = newRV_noinc(canary);
		if (GIMME_V == G_VOID) {
			sv_magicext(canary, (SV*)subref, PERL_MAGIC_ext, &weak_magic, (const char*)RETVAL, 0);
		}
		else {
			sv_magicext(canary, (SV*)subref, PERL_MAGIC_ext, &weak_magic, NULL, 0);
			mXPUSHs(RETVAL);
		}
