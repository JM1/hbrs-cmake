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

#ifndef HBRS_CMAKE_TEST_FUSE_IMPL_FNC_HPP
#define HBRS_CMAKE_TEST_FUSE_IMPL_FNC_HPP

#include <boost/hana/pair.hpp>
#include <boost/hana/tuple.hpp>
#include <boost/hana/integral_constant.hpp>

namespace detail {

struct impl1 {
    template <typename... Args>
    constexpr decltype(auto)
    operator()(Args&&... args) const {
        return boost::hana::true_c;
    }
};

struct impl2 {
    template <typename... Args>
    constexpr decltype(auto)
    operator()(Args&&... args) const {
        return boost::hana::false_c;
    }
};

/* namespace detail */ }

#define HBRS_CMAKE_TEST_FUSE_IMPL_FNC_IMPLS boost::hana::make_tuple( boost::hana::make_pair(fnc1, detail::impl1{}), boost::hana::make_pair(fnc2, detail::impl2{}) )

#endif // !HBRS_CMAKE_TEST_FUSE_IMPL_FNC_HPP
