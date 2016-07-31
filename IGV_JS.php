<!-- a php script that uses a java script that creaes a igv browser application. The php dynamically changes the parameteters needed to create the page to
 tailer the postion of the browser to the options chosen from browser html. --> 
<html>
    <head>
    </head>
    <body>
        <?php
             // make variables of POST output from Browser html 
             $gene = $_POST["gene"];
             $genome = $_POST["genome"];
             $tracks = $_POST["tracks"];
             // make varibles ready to be used by javascript set to default values in the event that nothing is chosen in the form 
             $annot = "";
             $genomefile ="";
             $genomeindex ="";
             // in the event the user choose's the rn4 genome                          
             if (strcmp($genome,'rn4')==0) {
             // run a system call of a Rscript for the RN4 cuffdiff output for the postion of the gene given in post 
                 $locus = system("Rscript gene_locus_RN4.r ".$gene);
             // reformat result so that it can be used in a location in the java script
                 $chrom = substr($locus, 5, -1);
             // set to the appropirtate gene annoation file and genome and genome index file 
                 $annot = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN4.gtf';
                 $genomefile = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN4.fa';
                 $genomeindex = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN4.fa.fai';
             };
             // in the event the user choose's the rn6 genome                          
             if (strcmp($genome,'rn6')==0) {
             // run a system call of a Rscript to each for the RN6 cuffdiff output for the postion of the gene given in post 
                 $locus = system("Rscript gene_locus_RN6.r ".$gene);
             // reformat result so that it can be used in a location in the java script
                 $chrom = substr($locus, 5, -1);
             // set to the appropirtate gene annoation file and genome and genome index file 
                 $annot = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN6.gtf';
                 $genomefile = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN6.fa';
                 $genomeindex = 'http://bioinf6.bioc.le.ac.uk/~sb746/genomes/RN6.fa.fai';
             };
             // in the event no postion is found set name chormosome  to gene name so later something is printed out  to remind the user of wat gene was that they chose 
             if (strcmp($chrom,'')==0) {
                 $chrom = $gene;
             };
             
//java script of browser 
            echo "<!-- Modified version of code taken from offical http://www.igv.org/web/doc/ website -->
<!-- Specifically Bam file example http://igv.org/web/examples/bam.html -->
<!-- language set to english --> 
<html lang=\"en\">
<head>
    <!-- Provides zoom in and out buttons and search button(maginifyglass)-->
    <!-- useing a CSS page found at.... -->
    <!--http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css -->
    <link rel=\"stylesheet\" type=\"text/css\"
          href=\"./font-awesome.min.css\"/>

    <!-- Needed CSS layout to display the igv tool in non defalt format-->
    <!-- useing CSS page found at.... -->
    <!-- view-source:http://igv.org/web/release/1.0.1/igv-1.0.1.css -->
    <link rel=\"stylesheet\" type=\"text/css\" href=\"./igv-1.0.1.css\">

    <!-- Integral jquery is needed for igv script to work-->
    <!-- useing Java Script pages found at.... -->
    <!-- view-source:http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js -->
    <!-- view-source:http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js -->
    <script type=\"text/javascript\" src=\"./jquery.min.js\"></script>
    <script type=\"text/javascript\" src=\"./jquery-ui.min.js\"></script>

    <!-- Source script of the java script version of igv the -->
    <!-- useing Java Script pages found at.... -->
    <!-- view-source:http://igv.org/web/release/1.0.1/igv-1.0.1.js -->
    <script type=\"text/javascript\" src=\"./igv-1.0.1.js\"></script>

</head>
<body>
<!-- Just above the browser remind the user what they chose  -->
Gene: ",$gene," Genome: ",$genome," Reads: ";

foreach ($tracks as $read) {echo $read;};
echo "
<!-- contains igv application has its layout-->
<div class=\"container-fluid\" id=\"igvDiv\"></div>

<!-- implement igv function, with parameters -->
<script type=\"text/javascript\">

    $(document).ready(function () {

        var div = $(\"#igvDiv\")[0],
                options = {
                    reference: {
/* Both genomes/gtf-file are modfied from illuminas igenome repositories http://support.illumina.com/sequencing/sequencing_software/igenome.html but have both 
index files and genome files edited to contain ERCC92 spike ins found at 
http://tools.thermofisher.com/content/sfs/manuals/ERCC92.zip
FastaURL and indexURL refer to files used by the rbwoser java script and the cytoband txt is the overaly picture that is used 
*/
                        fastaURL: \"",$genomefile,"\",
                        indexURL: \".",$genomeindex,"\",
                        cytobandURL:\"http://bioinf6.bioc.le.ac.uk/~sb746/cytoBand.txt\"
                       },
/*
set to the location of found by the Rscript with the apropirate annotation file (genes.gtf)
*/
                    locus: \"",$chrom,"\",
                    tracks: [ {
                            name: \"Genes\",
                            url: \"",$annot,"\"

                        },";
// for loop goes through list of reads chosen and genome and adds there track needded to the javascript run of the browser if they are present in the list linking to apropirote file 
                  foreach ($tracks as $read) {
                            if (strcmp($read,'PIR_1')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1177963.bam',
                                        name: 'SRR1177963'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1177963.bam',
                                        name: 'SRR1177963'
                                        },";
                                };
                            };

                            if (strcmp($read,'PIR_2')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1177964.bam',
                                        name: 'SRR1177964'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1177964.bam',
                                        name: 'SRR1177964'
                                        },";
                                };
                            };
           


                            if (strcmp($read,'PIR_3')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1177965.bam'
                                        name: 'SRR1177965'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1177965.bam',
                                        name: 'SRR1177965'
                                        },";
                                };
                            };

                            if (strcmp($read,'CTRL_1')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1178000.bam',
                                        name: 'SRR1178000'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1178000.bam',
                                        name: 'SRR1178000'
                                        },";
                                };
                            };

                            if (strcmp($read,'CTRL_2')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1178005.bam',
                                        name: 'SRR1178005'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1178005.bam',
                                        name: 'SRR1178005'
                                        },";
                                };
                            };

                            if (strcmp($read,'CTRL_3')==0) {
                                if (strcmp($genome,'rn4')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN4_SRR1178007.bam',
                                        name: 'SRR1178007'
                                        },";
                                };
                                if (strcmp($genome,'rn6')==0){
                                    echo "{
                                        url: 'http://bioinf6.bioc.le.ac.uk/~sb746/bam/RN6_SRR1178007.bam',
                                        name: 'SRR1178007'
                                        },";
                                };
                            };
                        };

             echo "]
                };
<!-- with options created attempt to make the browser useing the javascript -->
        igv.createBrowser(div, options);

    });

</script>
</body>";
        ?>

</html>
