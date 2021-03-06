% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/single_snps.R
\name{X4}
\alias{X4}
\title{X4}
\usage{
X4(Z, sub = which(Z[, 1]^2 + Z[, 2]^2 > 6))
}
\arguments{
\item{Z}{n x 2 matrix of Z scores; Z[,1]=Z_d, Z[,2]=Z_a}

\item{sub}{option to only calculate cFDR at a subset of Z scores; cFDR is computationally intensive to calculate.}
}
\value{
vector of values of X4
}
\description{
Compute test statistic X4, conditional false discovery rate of Z_d given Z_a
}
\details{
This test statistic is against a different null hypothesis than X1-X3; namely that the SNP of interest does not differentiate subgroups (ie, no requirement for high |Z_a|).

This test statistic does account for Z_a, however, by implicitly adapting for correlation between Z_a and Z_d, effectively reducing the threshold for Z_d association for SNPs with high Z_a score, if there is evidence that both tend to be high concurrently.

Note that the procedure of declaring non-null all SNPs with cFDR < alpha does not limit the false discovery rate of such SNPs to alpha(ie, the procedure is not analagous to the Benjamini-Hochberg FDR controlling procedure). A bound on the overall FDR can be obtained using the c2a function (below.)
}
\examples{
nn=100000
Z=abs(rbind(rmnorm(0.8*nn,varcov=diag(2)), rmnorm(0.15*nn,varcov=rbind(c(1,0),c(0,2^2))), rmnorm(0.05*nn,varcov=rbind(c(3^2,2),c(2,4^2)))));
X=X4(Z,sub=which(Z[,1]^2 + Z[,2]^2 > 6))
plotZ(Z,rlim=2); points(Z[which(X<0.001),],col="red",pch=16)
}
\author{
James Liley
}
