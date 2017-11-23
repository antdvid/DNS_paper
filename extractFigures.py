import os

FileName = "C:\\Users\\zgao\\Documents\\DNS_entr\\JGR2017-DNS-Supplement-Figures.tex"
figure_tag = "s"
#start reading file
count = 0
row_count = 0
col_count = 0
subfig_count = 0
imgs=[]
with open(FileName, encoding="UTF8") as fp:
    for line in fp:
        if "\\begin{figure}" in line: #clear buffer
            count += 1
            row_count = 0
            col_count = 0
            subfig_count = 0
            imgs=[]
        if "includegraphics" in line: #add to buffer
            imgs.append(line)
            subfig_count += 1
            if r'''\\''' in line:
                row_count += 1
        if "\\end{figure}" in line: #output buffer
            if row_count == 0:
                col_count = 1
            else:
                col_count = subfig_count / row_count
            imgs = [r"\begin{tabular}" + "{{*{0}c}}".format(int(col_count)) + "\n"] + imgs
            imgs.append(r"\end{tabular}")
            print("******** start outputing *************")
            latex_source = r'''\documentclass{standalone}
            \usepackage{graphicx}
            \usepackage{epstopdf}
            \begin{document}
            ''' + "\n" + "\n".join(imgs) + "\n" + r'''    \end{document}'''
            print(latex_source)
            print("********* end outputing *************")
            with open("latex_source_file.tex", "w") as text_file:
                text_file.write(latex_source)
            os.system("pdflatex latex_source_file.tex -job-name={0}".format("figure_{0}{1}".format(figure_tag, count)))

