define __defvars =
 allbins += $$($(1)bins)
 $(1)builds = $$(patsubst %,$(OUTDIR)/%,$$($(1)bins))
 allbuilds += $$($(1)builds)
 .PHONY: $(1) install-$(1) uninstall-$(1)
 $(1): $$($(1)builds)
 install-$(1): $$(addprefix install-,$$($(1)bins))
 uninstall-$(1): $$(addprefix uninstall-,$$($(1)bins))
endef
$(foreach target,$(targets),$(eval $(call __defvars,$(target))))

.PHONY: install uninstall $(addprefix install-,$(allbins)) $(addprefix uninstall-,$(allbins))

install: $(addprefix install-,$(targets))

$(addprefix $(BINDIR)/,$(allbins)): $(BINDIR)/%: $(OUTDIR)/%
	install -m 557 $< $(BINDIR)

$(addprefix install-,$(allbins)): install-%: $(BINDIR)/%

uninstall: $(addprefix uninstall-,$(targets))

$(addprefix uninstall-,$(allbins)): uninstall-%:
	rm -f $(BINDIR)/$*
