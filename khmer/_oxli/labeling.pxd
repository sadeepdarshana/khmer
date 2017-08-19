from libcpp cimport bool
from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp.set cimport set
from libcpp.memory cimport unique_ptr, shared_ptr, weak_ptr
from libc.stdint cimport uint8_t, uint32_t, uint64_t, uintptr_t

from .oxli_types cimport *
from .hashing cimport Kmer, CpKmer, KmerSet, CpKmerFactory, CpKmerIterator
from .parsing cimport CpReadParser, CpSequence
from .legacy_partitioning cimport (CpSubsetPartition, cp_pre_partition_info,
                                   SubsetPartition)
from .utils cimport oxli_raise_py_error

cdef extern from "oxli/labelhash.hh":

    cdef cppclass CpLabelHash "oxli::LabelHash":
        CpLabeHash(CpHashgraph *)

        CpHashgraph * graph

        TagLabelMap tag_labels
        LabelTagMap label_tag
        LabelSet all_labels

        size_t n_labels()
        void get_tag_labels(HashIntoType, LabelSet&) const
        void get_tags_from_label(Label, TagSet&) const
        void link_tag_and_label(const HashIntoType, const Label)
        unsigned int sweep_label_neighborhood(const string&,
                                              LabelSet&,
                                              unsigned int,
                                              bool, bool)
        void traverse_labels_and_resolve(const HashIntoTypeSet,
                                         LabelSet&)
        void save_labels_and_tags(string)
        void load_labels_and_tags(string)

        void label_across_high_degree_nodes(const char *,
                                            HashIntoTypeSet&,
                                            const Label)

        void consume_seqfile_and_tag_with_labels[SeqIO](string &,
                                                       unsigned int &,
                                                       unsigned long long &) except +oxli_raise_py_error

        void consume_seqfile_and_tag_with_labels[SeqIO](shared_ptr[CpReadParser[SeqIO]]&
                                                       unsigned int &,
                                                       unsigned long long &) except +oxli_raise_py_error
        void consume_partitioned_fasta_and_tag_with_labels[SeqIO](string &,
                                                       unsigned int &,
                                                       unsigned long long &) except +oxli_raise_py_error
        void consume_sequence_and_tag_with_labels(const string &,   
                                                  unsigned long long&,
                                                  Label)
        void consume_sequence_and_tag_with_labels(const string &,   
                                                  unsigned long long&,
                                                  Label,
                                                  HashIntoTypeSet *)

