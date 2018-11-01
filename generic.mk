define __defvars =
 allbins += $$($(1)bins)
 $(1)builds = $$(patsubst %,$(OUTDIR)/%,$$($(1)bins))
 allbuilds += $$($(1)builds)
 $(1): $$($(1)builds)
 install-$(1): $$(addprefix install-,$$($(1)bins))
 uninstall-$(1): $$(addprefix uninstall-,$$($(1)bins))
endef
$(foreach target,$(targets),$(eval $(call __defvars,$(target))))

install: $(addprefix install-,$(targets))

$(addprefix install-,$(allbins)): install-%: $(OUTDIR)/%
	install -m 557 $< $(BINDIR)

uninstall: $(addprefix uninstall-,$(targets))

$(addprefix uninstall-,$(allbins)): uninstall-%:
	rm -f $(BINDIR)/$*
