##' Generates a Berry logo in ggplot from a positional weight matrix
##'
##' @param pwm matrix of fractional nucleotide frequencies 0.00-1.00
##'    here rows are A, C, G, T and columns are position
##' @param gc_content optional the GC content of the source genome    
##' @param zero optional a placeholder estimate for true frequency when 0 is observed
##' @return A ggplot2 object, use print() to display
##' 
##' @export
##' 
##' @examples
##' freqs<-matrix(data=c(0.25,0.65,0.87,0.92,0.16,0.16,0.04,0.98,0.98,1.00,0.02,0.10,0.10,0.80,0.98,0.91,0.07,0.07,
##'    0.11,0.05,0.04,0.00,0.26,0.17,0.00,0.01,0.00,0.00,0.29,0.17,0.01,0.03,0.00,0.00,0.32,0.32,
##'    0.53,0.26,0.07,0.02,0.53,0.18,0.96,0.01,0.00,0.00,0.65,0.01,0.89,0.17,0.01,0.09,0.59,0.12,
##'    0.11,0.04,0.02,0.06,0.05,0.49,0.00,0.00,0.02,0.00,0.04,0.72,0.00,0.00,0.01,0.00,0.02,0.49),byrow=TRUE,nrow=4,dimnames=list(c('A','C','G','T')))
##' p<-berrylogo(freqs)
##' print(p)
berrylogo<-function(pwm,gc_content=.41,zero=.0001){  
  backFreq<-list(A=(1-gc_content)/2,C=gc_content/2,G=gc_content/2,T=(1-gc_content)/2)
  pwm[pwm==0]<-zero
  bval<-plyr::laply(names(backFreq),function(x){log(pwm[x,])-log(backFreq[[x]])})
  row.names(bval)<-names(backFreq)
  p<-ggplot2::ggplot(reshape2::melt(bval,varnames=c("nt","pos")),ggplot2::aes(x=pos,y=value,label=nt))+
    ggplot2::geom_abline(ggplot2::aes(slope=0), colour = "grey",size=2)+
    ggplot2::geom_text(ggplot2::aes(colour=factor(nt)),size=8)+
    ggplot2::theme(legend.position="none")+
    ggplot2::scale_x_continuous(name="Position",breaks=1:ncol(bval))+
    ggplot2::scale_y_continuous(name="Log relative frequency")
  return(p)
}
