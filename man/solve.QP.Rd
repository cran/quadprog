\name{solve.QP}
\alias{solve.QP}
\alias{solve.QP.compact}
\title{
Solve a Quadratic Programming Problem
}
\usage{
solve.QP        (Dmat, dvec, Amat,       bvec, meq=0, factorized=FALSE)
solve.QP.compact(Dmat, dvec, Amat, Aind, bvec, meq=0, factorized=FALSE)
}
\arguments{
\item{Dmat}{matrix appearing in the quadratic function to be minimized.}
\item{dvec}{vector appearing in the quadratic function to be minimized.}
\item{Amat}{
    For \code{solve.QP()}:\cr
    matrix defining the constraints under which we want to minimize the
    quadratic function.

    For \code{solve.QP.compact()}:\cr
    matrix containing the non-zero elements of the matrix A that defines
    the constraints.  If mi denotes the number of non-zero elements in the
    i-th column of A then the first mi entries of the i-th column of
    \code{Amat} hold these non-zero elements.
    (If maxmi denoted the maximum of all mi, then each column of \code{Amat}
    may have arbitrary elements from row mi+1 to row maxmi in the i-th
    column)
}
\item{Aind}{
    matrix of integers.  The first element of each column gives the number of
    non-zero elements in the corresponding column of the matrix A.  The
    following entries in each column contain the indexes of the rows in
    which these non-zero elements are.
}
\item{bvec}{vector holding the values of b0 (defaults to zero).}
\item{meq}{the first \code{meq} constraints are treated as equality
    constraints, all further as inequality constraints (defaults to 0).
}
\item{factorized}{
    logical flag: if \code{TRUE}, then we are passing
    \eqn{R^{-1}} (where D = \eqn{R^T R}) instead of the matrix D  in the
    argument \code{Dmat}.}
}
\value{
    a list with the following components:
    \item{solution}{vector containing the solution of the quadratic
	programming problem.}
    \item{value}{scalar, the value of the quadratic function at the solution.}
    }
    \item{unconstrained.solution}{
	vector containing the unconstrained minimizer of the quadratic function.
    }
    \item{iterations}{
	vector of length 2, the first component contains the number of
	iterations the algorithm needed, the second indicates how often
	constraints became inactive after becoming active first.
	vector with the indices of the active constraints at the solution.
    }
}
\description{
    This routine implements the dual method of Goldfarb and Idnani (1982,
    1983) for solving quadratic programming problems.
}
\references{
Goldfarb, D. and Idnani, A.  (1982).
Dual and Primal-Dual Methods for Solving Strictly Convex
Quadratic Programs.  In
Numerical Analysis
J.P. Hennart, ed. Springer-Verlag, Berlin. pp. 226-239.

Goldfarb, D. and Idnani, A. (1983).
A numerically stable dual method for solving strictly convex quadratic
programs.
Mathematical Programming \bold{27}, 1-33.
}
\seealso{Matrix Inversion with \code{\link{solve}}.
}
\examples{
# Assume we want to minimize: -(0 5 0) \%*\% b + 1/2 b^T b
# under the constraints:      A^T b >= b0
# with b0 = (-8,2,0)^T
# and      (-4  2  0)
#      A = (-3  1 -2)
#          ( 0  0  1)
# we can use solve.QP as follows:
#
Dmat       <- matrix(0,3,3)
diag(Dmat) <- 1
dvec       <- c(0,5,0)
bvec       <- c(-8,2,0)

Amat0       <- matrix(c(-4,-3,0, 2,1,0, 0,-2,1),3,3)
solve.QP(Dmat,dvec, Amat0, bvec=bvec)

# Now with solve.QP.compact :
#
Aind <- rbind(c(2,2,2),
              c(1,1,2),
              c(2,2,3))
Amat <- rbind(c(-4,2,-2),
              c(-3,1, 1))
solve.QP.compact(Dmat,dvec,Amat,Aind,bvec=bvec)

}
\keyword{optimize}
% Converted by Sd2Rd version 0.2-a5.
