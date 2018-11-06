/* Copyright (c) 2016-2018 Jakob Meng, <jakobmeng@web.de>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */


#define BOOST_TEST_MODULE fuse_test
#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#include <boost/test/unit_test.hpp>

#include <boost/hana/type.hpp>
#include <boost/hana/transform.hpp>
#include <boost/hana/filter.hpp>
#include <boost/hana/second.hpp>
#include <boost/hana/pair.hpp>
#include <boost/hana/equal.hpp>
#include <boost/hana/integral_constant.hpp>

#include <decl/fnc.hpp>
#include <fused/fnc.hpp>

namespace hana = boost::hana;

template<typename OperationMatch>
struct fnc_filter {
	template <typename Operation, typename OperationImpl>
	constexpr decltype(auto)
	operator()(hana::pair<Operation, OperationImpl> const&) const {
		return hana::type_c<Operation> == hana::type_c<OperationMatch>;
	}
};

#define _MF_IMPL_OF(f_impls, f_type)                                                                          \
	hana::transform(hana::filter(f_impls, fnc_filter<f_type>{}), hana::second)

BOOST_AUTO_TEST_SUITE(fuse_test)

BOOST_AUTO_TEST_CASE(fuse_test_1) {
	namespace hana = boost::hana;

	static_assert(std::is_same<
		decltype(_MF_IMPL_OF(HBRS_CMAKE_TEST_FNC_IMPLS, fnc1_t)),
		decltype(hana::make_tuple(detail::impl1{}))
	>::value, "");
	
	static_assert(std::is_same<
		decltype(_MF_IMPL_OF(HBRS_CMAKE_TEST_FNC_IMPLS, fnc2_t)),
		decltype(hana::make_tuple(detail::impl2{}))
	>::value, "");
}

BOOST_AUTO_TEST_SUITE_END()
