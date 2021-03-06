% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/single_snps.R
\name{c2a}
\alias{c2a}
\title{c2a}
\usage{
c2a(Z, X4c, pars0 = NULL, pi0 = NULL, sigma = NULL, xmax = 12,
  ymax = 12, res = 0.01)
}
\arguments{
\item{Z}{n x 2 matrix of Z scores; Z[,1]=Z_d, Z[,2]=Z_a}

\item{X4c}{vector of values of cFDR at which to compute overall FDR}

\item{pars0}{parameters of null model; needed for determining P(Z_a<z_a)}

\item{pi0}{proportion of SNPs not associated with phenotype; overrides pars0 if set}

\item{sigma}{standard deviation of observed Z_a scores in SNPs associated with the phenotype; overrides pars0 if set.}

\item{xmax}{compute integral over [0,xmax] x [0,xmax] as approximation to [0,inf] x [0,inf]}

\item{res}{compute integral at gridpoints with this spacing.}

\item{vector}{of FDR values corresponding to X4c}
}
\value{
list of FDR values
}
\description{
Compute an upper bound on the false discovery rate amongst SNPs with X4<X4c
}
\details{
Bound is based on estimating the area of the unit square satisfying X4<alpha. It is typically conservative.

Computation requires parametrisation of the distribution of Z_a, assumed to have a distribution of N(0,1) with probability pi0 and N(0,sigma^2) with probability 1-pi0. Values of pi0 and sigma can be obtained from the fitted parameters of the null model, or specified directly.

The probability is computed using a numerical integral over the (+/+) quadrant and the range and resolution of the integral can be set.
}
\examples{
nn=100000
Z=abs(rbind(rmnorm(0.8*nn,varcov=diag(2)), rmnorm(0.15*nn,varcov=rbind(c(1,0),c(0,2^2))), rmnorm(0.05*nn,varcov=rbind(c(3^2,2),c(2,4^2)))));
X=X4(Z,sub=which(Z[,1]^2 + Z[,2]^2 > 6))
Xm=which(X<0.05); Xsub=Xm[order(runif(length(Xm)))[1:100]] # sample of cFDR values 
true_fdr=rep(0,100); for (i in 1:100) true_fdr[i]=length(which(X[1:(0.95*nn)] <= X[Xsub[i]]))/length(which(X<=X[Xsub[i]])) # true FDR values (empirical)
fdr=c2a(Z,X[Xsub],pars0=c(0.8,0.15,3,2,4,2)) # estimated FDR using area method
plot(true_fdr,fdr,xlab="True FDR",ylab="Estimated",col="red"); points(true_fdr,X[Xsub],col="blue"); abline(0,1); legend(0.1*max(true_fdr),0.7*max(fdr),c("Area method", "cFDR"),col=c("red", "blue"),pch=c(1,1)) # cFDR underestimates true FDR; area method gives good approximation.
}
\author{
James Liley
}
