setGeneric("berrylogo", function(x) {
  standardGeneric("berrylogo")
})

#' Get the total width of an ascii ruler
#' @export
#' @param x the asciiruler
#' @param ... additional arguments
berrylogo <- function(x,...) {
  if (is(x, "PWMatrix")){
    #TFBSTools uses the same class name regardless of the frequency units
    #but PWM have the pseudocounts
    if("pseudocounts" %in% methods::slotNames(x)){return(berrylogo.PWM(x))}
    return(berrylogo.PFM(x,...))
  }
  if (methods::is(x, "matrix")){return(berrylogo.matrix(x,...))}
}

##' Generates a Berry logo in ggplot from a positional weight matrix
##'
##' @param pwm matrix of fractional nucleotide frequencies 0.00-1.00
##'    here rows are A, C, G, T and columns are position
##' @param gc_content optional the GC content of the source genome    
##' @param zero optional a pseudocount placeholder estimate for true frequency when 0 is observed
##' @param base the log base to use, exp(1) by default
##' @return A ggplot2 object, use print() to display
##' 
##' @export
##' 
##' @examples
##' freqs<-matrix(data = c(0.25,0.65,0.87,0.92,0.16,0.16,0.04,0.98,0.98
##' ,1.00,0.02,0.10,0.10,0.80,0.98,0.91,0.07,0.07,0.11,0.05,0.04,0.00
##' ,0.26,0.17,0.00,0.01,0.00,0.00,0.29,0.17,0.01,0.03,0.00,0.00,0.32
##' ,0.32,0.53,0.26,0.07,0.02,0.53,0.18,0.96,0.01,0.00,0.00,0.65,0.01
##' ,0.89,0.17,0.01,0.09,0.59,0.12,0.11,0.04,0.02,0.06,0.05,0.49,0.00
##' ,0.00,0.02,0.00,0.04,0.72,0.00,0.00,0.01,0.00,0.02,0.49)
##' ,byrow = TRUE,nrow = 4,dimnames = list(c('A','C','G','T')))
##' p<-berrylogo(freqs)
##' print(p)
berrylogo.matrix<-function(pwm,gc_content = .41,zero = .0001, base = exp(1)){  
  backFreq<-list(A = (1-gc_content)/2,C = gc_content/2,G = gc_content/2,T = (1-gc_content)/2)
  pwm[pwm == 0]<-zero
  bval<-plyr::laply(names(backFreq),function(x){log(pwm[x,],base=base)-log(backFreq[[x]],base=base)})
  row.names(bval)<-names(backFreq)
  if(base==exp(1)) return(ggberry(bval,ylab="Log relative frequency"))
  return(ggberry(bval,ylab=paste0("Log",base," frelative frequency")))
}

##' Generates a Berry logo in ggplot TFBSTools
##' Positional Weight Matrix, which is log2-based
##'
##' @param pwm matrix of fractional nucleotide frequencies in log2 scale
##'    here rows are A, C, G, T and columns are position
##' @return A ggplot2 object, use print() to display
##' 
##' @export
berrylogo.PWM<-function(pwm){
  return(ggberry(pwm@profileMatrix,ylab="Log2 relative frequency"))
}

##' Generates a Berry logo in ggplot from a TFBSTools
##' Positional Frequency Matrix, which is count based
##' @param pfm matrix of fractional nucleotide counts
##'    here rows are A, C, G, T and columns are position
##' @param ... additional arguments
berrylogo.PFM<-function(pfm,...){
  pwm<-pfm@profileMatrix/colSums(pfm@profileMatrix)
  return(berrylogo.matrix(pwm,...))
}

##' Generates a Berry logo in ggplot from a
##' log transformed matrix
##' @param bval matrix of log-tx freqs
##'    here rows are A, C, G, T and columns are position
##' @param ylab the y-axis label
ggberry<-function(bval,ylab){
  p<-ggplot2::ggplot(reshape2::melt(bval,varnames = c("nt","pos")),
                     ggplot2::aes_string(x = 'pos', y = 'value',label = 'nt'))+
    ggplot2::geom_hline(yintercept = 0, colour = "grey",size = 2)+
    ggplot2::geom_text(ggplot2::aes_string(colour = 'factor(nt)'),size = 8,fontface = "bold")+
    ggplot2::theme(legend.position = "none")+
    ggplot2::scale_x_continuous(name = "Position",breaks = 1:ncol(bval))+
    ggplot2::scale_y_continuous(name = ylab)
  return(p)
}