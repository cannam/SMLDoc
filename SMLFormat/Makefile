# Makefile for SMLFormat
# $Id: Makefile.in,v 1.21 2007/12/13 08:59:46 katsu Exp $

srcdir = .
builddir = .
top_srcdir = .
top_builddir = .

include ./commonrule

VPATH = .

TARGETS = smlformat

LEXFILES =  $(srcdir)/generator/main/ml.lex
YACCFILES = $(srcdir)/generator/main/ml.grm

GENSOURCES = $(LEXFILES:.lex=.lex.sml) \
             $(YACCFILES:.grm=.grm.sml) \
             $(YACCFILES:.grm=.grm.sig) \
             $(YACCFILES:.grm=.grm.desc)

SOURCES = generator/main/AST.sig \
          generator/main/Ast.sml \
          generator/main/ASTUTIL.sig \
          generator/main/AstUtil.sml \
          generator/main/BasicFormattersEnv.sml \
          generator/main/Constants_MLton.sml \
          generator/main/Constants_SMLNJ.sml \
          generator/main/ErrorQueue.sml \
          generator/main/FormatTemplate.sml \
          generator/main/FORMATTER_GENERATOR.sig \
          generator/main/FormatterGenerator.sml \
          generator/main/Main.sml \
          generator/main/MLPARSER.sig \
          generator/main/MLParser.sml \
          generator/main/PPGMain.sml \
          generator/main/PPGSourceTool.sml \
          generator/main/TokenTable.sml \
          generator/main/Utility.sml \
          $(GENSOURCES)

LIBFILES = smlformatlib.sml \
           formatlib/main/AssocResolver.sml \
           formatlib/main/BASIC_FORMATTERS.sig \
           formatlib/main/BasicFormatters.sml \
           formatlib/main/FORMAT_EXPRESSION.sig \
           formatlib/main/FormatExpression.sml \
           formatlib/main/FormatExpressionTypes.sml \
           formatlib/main/FormatExpressionTypes_SMLSharp.sml \
           formatlib/main/PreProcessedExpression.sml \
           formatlib/main/PreProcessor.sml \
           formatlib/main/PrettyPrinter.sml \
           formatlib/main/PRINTER_PARAMETER.sig \
           formatlib/main/PrinterParameter.sml \
           formatlib/main/SMLFORMAT.sig \
           formatlib/main/SMLFormat.sml \
           formatlib/main/Truncator.sml \
           formatlib/main/sources.cm \
           formatlib/main/sources.sml

all: $(TARGETS)

install: $(TARGETS) $(LIBFILES)
	$(INSTALL) -d -m 755 '$(DESTDIR)$(bindir)'
	$(MAKESML) -B '$(DESTDIR)$(bindir)' -H '$(DESTDIR)$(heapdir)' \
	           -i -o smlformat
	$(INSTALL) -d -m 755 '$(DESTDIR)$(libdir_smlformat)'
	$(INSTALL) -d -m 755 '$(DESTDIR)$(libdir_smlformat)/formatlib'
	$(INSTALL) -d -m 755 '$(DESTDIR)$(libdir_smlformat)/formatlib/main'
	set -x; for i in $(LIBFILES); do \
	  $(INSTALL_DATA) '$(srcdir)/'"$$i" \
	                  '$(DESTDIR)$(libdir_smlformat)/'"$$i";\
	done

clean:
	-rm -rf $(srcdir)/generator/.cm $(srcdir)/generator/CM
	-rm -rf $(srcdir)/formatlib/.cm $(srcdir)/formatlib/CM
	-rm -f $(GENSOURCES)
	$(MAKESML) -r -o smlformat

smlformat: generator/main/sources.cm $(SOURCES)
	$(MAKESML) -o $@ $(srcdir)/generator/main/sources.cm

$(srcdir)/generator/main/ml.lex.sml: generator/main/ml.lex
	$(MLLEX) $(srcdir)/generator/main/ml.lex

$(srcdir)/generator/main/ml.grm.sml $(srcdir)/generator/main/ml.grm.sig: generator/main/ml.grm
	$(MLYACC) $(srcdir)/generator/main/ml.grm

doc/api/index.html: $(srcdir)/formatlib/smldoc.cfg $(LIBFILES) 
	-rm -rf ./doc/api
	mkdir -p ./doc/api
	$(SMLDOC) -a $(srcdir)/formatlib/smldoc.cfg --directory=./doc/api

# Makefile.in ends here.
